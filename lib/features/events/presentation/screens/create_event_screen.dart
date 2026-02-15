import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  final Event? eventToEdit;

  const CreateEventScreen({super.key, this.eventToEdit});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _venueController;
  late TextEditingController _addressController;
  late TextEditingController _categoryController;

  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final event = widget.eventToEdit;
    _titleController = TextEditingController(text: event?.title ?? '');
    _descriptionController = TextEditingController(
      text: event?.description ?? '',
    );
    _venueController = TextEditingController(text: event?.venueName ?? '');
    _addressController = TextEditingController(text: event?.venueAddress ?? '');
    _categoryController = TextEditingController(
      text: event?.categoryId ?? 'General',
    );

    if (event != null) {
      _selectedDate = event.dateStart;
      _selectedTime = TimeOfDay.fromDateTime(event.dateStart);
    } else {
      _selectedDate = DateTime.now().add(const Duration(days: 1));
      _selectedTime = const TimeOfDay(hour: 18, minute: 0);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _venueController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageFile == null && widget.eventToEdit == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an event image')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final date = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final currentUser = ref.read(currentUserProvider);

      if (widget.eventToEdit == null) {
        final event = Event(
          id: '',
          title: _titleController.text,
          description: _descriptionController.text,
          dateStart: date,
          venueName: _venueController.text,
          venueAddress: _addressController.text,
          categoryId: _categoryController.text,
          organizerId: currentUser?.id ?? '',
          participantsCount: 0,
          isAttending: false,
          isFavorite: false,
        );

        await ref.read(eventRepositoryProvider).createEvent(event, _imageFile);
      } else {
        final event = widget.eventToEdit!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          dateStart: date,
          venueName: _venueController.text,
          venueAddress: _addressController.text,
          categoryId: _categoryController.text,
          // organizerId should not change
        );

        await ref.read(eventRepositoryProvider).updateEvent(event, _imageFile);
      }

      if (mounted) {
        context.pop();
        ref.invalidate(eventsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.eventToEdit == null
                  ? 'Event created successfully!'
                  : 'Event updated successfully!',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.eventToEdit != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Event' : 'Create Event')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : (isEditing && widget.eventToEdit!.imageUrl != null)
                      ? DecorationImage(
                          image: NetworkImage(widget.eventToEdit!.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child:
                    (_imageFile == null &&
                        (!isEditing || widget.eventToEdit!.imageUrl == null))
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Title'),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _venueController,
                    decoration: const InputDecoration(labelText: 'Venue Name'),
                    validator: (v) => v?.isEmpty == true ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Full Address'),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Date & Time'),
              subtitle: Text(
                DateFormat('yyyy-MM-dd HH:mm').format(
                  DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  ),
                ),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (d != null) {
                  final t = await showTimePicker(
                    context: context, // ignore: use_build_context_synchronously
                    initialTime: _selectedTime,
                  );
                  if (t != null) {
                    setState(() {
                      _selectedDate = d;
                      _selectedTime = t;
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(isEditing ? 'Update Event' : 'Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
