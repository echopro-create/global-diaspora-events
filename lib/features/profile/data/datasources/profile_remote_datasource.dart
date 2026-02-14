import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_profile.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_interest.dart';

class ProfileRemoteDataSource {
  final SupabaseClient _client;

  ProfileRemoteDataSource(this._client);

  Future<UserProfile> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return UserProfile.fromJson(response);
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _client.from('profiles').upsert(profile.toJson());
  }

  Future<List<UserInterest>> getInterests() async {
    final response = await _client.from('interests').select();
    return (response as List)
        .map((json) => UserInterest.fromJson(json))
        .toList();
  }

  Future<void> updateUserInterests(
    String userId,
    List<String> interestIds,
  ) async {
    // Delete existing
    await _client.from('user_interests').delete().eq('user_id', userId);

    // Insert new
    if (interestIds.isNotEmpty) {
      final data = interestIds
          .map((id) => {'user_id': userId, 'interest_id': id})
          .toList();
      await _client.from('user_interests').insert(data);
    }
  }
}
