import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';
import 'package:global_diaspora_events/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:global_diaspora_events/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_interest.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_profile.dart';
import 'package:global_diaspora_events/features/profile/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Data Source
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  return ProfileRemoteDataSource(Supabase.instance.client);
});

// Repository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(profileRemoteDataSourceProvider));
});

// Current User Profile Provider
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repository = ref.watch(profileRepositoryProvider);
  try {
    return await repository.getProfile(user.id);
  } catch (e) {
    // If profile doesn't exist, return a basic one based on auth data
    return UserProfile(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
});

// Profile by ID Provider
final profileByIdProvider = FutureProvider.family<UserProfile?, String>((
  ref,
  userId,
) async {
  final repository = ref.watch(profileRepositoryProvider);
  return await repository.getProfile(userId);
});

// Available Interests Provider
final interestsProvider = FutureProvider<List<UserInterest>>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return await repository.getInterests();
});

// Profile Controller for mutations
class ProfileController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateProfile(UserProfile profile) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      await repository.updateProfile(profile);
      ref.invalidate(userProfileProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateInterests(String userId, List<String> interestIds) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      await repository.updateUserInterests(userId, interestIds);
      ref.invalidate(userProfileProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, void>(() {
      return ProfileController();
    });
