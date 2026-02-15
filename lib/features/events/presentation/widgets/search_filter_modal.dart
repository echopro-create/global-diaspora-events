import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/events/domain/models/event_filter.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/events_feed_screen.dart';

class SearchFilterModal extends ConsumerStatefulWidget {
  const SearchFilterModal({super.key});

  @override
  ConsumerState<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends ConsumerState<SearchFilterModal> {
  String? _selectedCategory;
  DateTime? _selectedDate;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentfilter = ref.read(filterProvider);
    if (currentfilter != null) {
      _selectedCategory = currentfilter.categoryId;
      _selectedDate = currentfilter.date;
      _cityController.text = currentfilter.city ?? '';
    }
  }

  void _applyFilter() {
    final filter = EventFilter(
      categoryId: _selectedCategory,
      date: _selectedDate,
      city: _cityController.text.isNotEmpty ? _cityController.text : null,
    );
    ref.read(filterProvider.notifier).state = filter;
    Navigator.of(context).pop();
  }

  void _resetFilter() {
    ref.read(filterProvider.notifier).state = null;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Events',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Category'),
          Wrap(
            spacing: 8,
            children: ['Concerts', 'Stand-up', 'Business', 'Sports', 'Kids']
                .map((category) {
                  return FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : null;
                      });
                    },
                  );
                })
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('Date'),
          ListTile(
            title: Text(
              _selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString().split(' ')[0],
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilter,
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applyFilter,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
