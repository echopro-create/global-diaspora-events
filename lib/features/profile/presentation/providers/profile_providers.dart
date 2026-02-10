import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';

/// Provider для ProfileRemoteDataSource.
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  return ProfileRemoteDataSource(ref.watch(supabaseClientProvider));
});

/// Provider для ProfileRepository.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(profileRemoteDataSourceProvider));
});

/// Provider для текущего профиля пользователя.
final currentProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(user.id);
});

/// Provider для интересов текущего пользователя.
final userInterestsProvider = FutureProvider<List<UserInterest>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final repo = ref.watch(profileRepositoryProvider);
  return repo.getInterests(user.id);
});

/// Notifier для обновления профиля.
final updateProfileProvider =
    FutureProvider.family<
      UserProfile,
      ({
        String? displayName,
        String? originCountry,
        String? currentCity,
        double? latitude,
        double? longitude,
      })
    >((ref, params) async {
      final user = ref.watch(currentUserProvider);
      if (user == null) throw Exception('Not authenticated');

      final repo = ref.watch(profileRepositoryProvider);
      final result = await repo.updateProfile(
        userId: user.id,
        displayName: params.displayName,
        originCountry: params.originCountry,
        currentCity: params.currentCity,
        latitude: params.latitude,
        longitude: params.longitude,
      );

      // Инвалидируем кэш профиля
      ref.invalidate(currentProfileProvider);
      return result;
    });
