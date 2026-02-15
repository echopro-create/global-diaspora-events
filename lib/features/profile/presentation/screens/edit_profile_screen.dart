import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_profile.dart';
import 'package:global_diaspora_events/features/profile/presentation/providers/profile_providers.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _displayNameController;
  late TextEditingController _bioController;
  late TextEditingController _currentCityController;
  late TextEditingController _countryOfOriginController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _bioController = TextEditingController();
    _currentCityController = TextEditingController();
    _countryOfOriginController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _currentCityController.dispose();
    _countryOfOriginController.dispose();
    super.dispose();
  }

  void _initializeControllers(UserProfile? profile) {
    if (profile != null) {
      if (_displayNameController.text.isEmpty) {
        _displayNameController.text = profile.displayName ?? '';
      }
      if (_bioController.text.isEmpty) {
        _bioController.text = profile.bio ?? '';
      }
      if (_currentCityController.text.isEmpty) {
        _currentCityController.text = profile.currentCity ?? '';
      }
      if (_countryOfOriginController.text.isEmpty) {
        _countryOfOriginController.text = profile.countryOfOrigin ?? '';
      }
    }
  }

  Future<void> _saveProfile(UserProfile? currentProfile) async {
    if (!_formKey.currentState!.validate() || currentProfile == null) return;

    setState(() => _isLoading = true);

    final updatedProfile = currentProfile.copyWith(
      displayName: _displayNameController.text.trim(),
      bio: _bioController.text.trim(),
      currentCity: _currentCityController.text.trim(),
      countryOfOrigin: _countryOfOriginController.text.trim(),
    );

    try {
      await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(updatedProfile);
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => userProfileAsync.asData?.value != null
                  ? _saveProfile(userProfileAsync.asData!.value)
                  : null,
            ),
        ],
      ),
      body: userProfileAsync.when(
        data: (profile) {
          _initializeControllers(profile);
          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_isLoading) const LinearProgressIndicator(),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(labelText: 'Display Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a display name'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _currentCityController,
                  decoration: const InputDecoration(labelText: 'Current City'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countryOfOriginController,
                  decoration: const InputDecoration(
                    labelText: 'Country of Origin',
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
