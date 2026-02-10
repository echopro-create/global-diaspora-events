import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';

/// Remote data source для профиля пользователя (Supabase).
class ProfileRemoteDataSource {
  final SupabaseClient _client;

  ProfileRemoteDataSource(this._client);

  /// Получить текущего авторизованного пользователя.
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Получить профиль по ID.
  Future<UserProfile?> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserProfile.fromJson(response);
  }

  /// Обновить профиль пользователя.
  Future<UserProfile> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
      'display_name': ?displayName,
      'avatar_url': ?avatarUrl,
      'origin_country': ?originCountry,
      'current_city': ?currentCity,
      'latitude': ?latitude,
      'longitude': ?longitude,
    };

    final response = await _client
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  // ─── User Interests ───────────────────────────────────────────

  /// Получить интересы пользователя.
  Future<List<UserInterest>> getInterests(String profileId) async {
    final response = await _client
        .from('user_interests')
        .select()
        .eq('profile_id', profileId)
        .order('weight', ascending: false);

    return (response as List)
        .map((json) => UserInterest.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Добавить интерес.
  Future<UserInterest> addInterest(UserInterest interest) async {
    final response = await _client
        .from('user_interests')
        .insert(interest.toJson())
        .select()
        .single();

    return UserInterest.fromJson(response);
  }

  /// Удалить интерес.
  Future<void> removeInterest(String interestId) async {
    await _client.from('user_interests').delete().eq('id', interestId);
  }

  /// Добавить несколько интересов за раз (для импорта из Spotify).
  Future<List<UserInterest>> addInterestsBatch(
    List<UserInterest> interests,
  ) async {
    if (interests.isEmpty) return [];

    final response = await _client
        .from('user_interests')
        .insert(interests.map((i) => i.toJson()).toList())
        .select();

    return (response as List)
        .map((json) => UserInterest.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
