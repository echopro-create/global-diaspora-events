import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/events/domain/models/comment.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/social/domain/repositories/social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  final SupabaseClient _client;

  SocialRepositoryImpl(this._client);

  @override
  Future<List<Comment>> getComments(String eventId) async {
    // We assume there's a view or a join that gives us author details
    // For now, simpler implementation fetching just comments
    // In a real app, we'd join with 'profiles' table.
    // Supabase supports this via: .select('*, profiles(full_name, avatar_url)')

    final response = await _client
        .from('comments')
        .select('*, profiles(full_name, avatar_url)')
        .eq('event_id', eventId)
        .order('created_at', ascending: true);

    return (response as List).map((json) {
      // Flatten the profile data into the comment map if needed by the model,
      // or update the model to handle the nested profile object.
      // Let's manually map it for now since our model has flat fields
      final profile = json['profiles'] as Map<String, dynamic>?;
      final mutableJson = Map<String, dynamic>.from(json);

      if (profile != null) {
        mutableJson['author_name'] = profile['full_name'];
        mutableJson['author_avatar'] = profile['avatar_url'];
      }

      return Comment.fromJson(mutableJson);
    }).toList();
  }

  @override
  Future<void> addComment(String eventId, String text) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client.from('comments').insert({
      'event_id': eventId,
      'profile_id': userId,
      'text': text,
    });
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client
        .from('comments')
        .delete()
        .eq('id', commentId)
        .eq('profile_id', userId); // Security: only delete own comments
  }

  @override
  Future<void> followUser(String targetUserId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');
    if (userId == targetUserId) throw Exception('Cannot follow yourself');

    await _client.from('follows').insert({
      'follower_id': userId,
      'following_id': targetUserId,
    });
  }

  @override
  Future<void> unfollowUser(String targetUserId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client
        .from('follows')
        .delete()
        .eq('follower_id', userId)
        .eq('following_id', targetUserId);
  }

  @override
  Future<bool> isFollowing(String targetUserId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    final response = await _client
        .from('follows')
        .select()
        .eq('follower_id', userId)
        .eq('following_id', targetUserId)
        .maybeSingle();

    return response != null;
  }

  @override
  Future<List<String>> getFollowers(String userId) async {
    final response = await _client
        .from('follows')
        .select('follower_id')
        .eq('following_id', userId);

    return (response as List).map((e) => e['follower_id'] as String).toList();
  }

  @override
  Future<List<String>> getFollowing(String userId) async {
    final response = await _client
        .from('follows')
        .select('following_id')
        .eq('follower_id', userId);

    return (response as List).map((e) => e['following_id'] as String).toList();
  }

  @override
  Future<int> getFollowersCount(String userId) async {
    final count = await _client
        .from('follows')
        .count(CountOption.exact)
        .eq('following_id', userId);
    return count;
  }

  @override
  Future<int> getFollowingCount(String userId) async {
    final count = await _client
        .from('follows')
        .count(CountOption.exact)
        .eq('follower_id', userId);
    return count;
  }

  @override
  Future<List<Event>> getFeedEvents() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // 1. Get IDs of users I follow
    final followingIds = await getFollowing(userId);
    if (followingIds.isEmpty) return [];

    // 2. Fetch events created by them
    final response = await _client
        .from('events')
        .select()
        .filter(
          'organizer_id',
          'in',
          followingIds,
        ) // Assuming 'organizer_id' exists on events table
        .order('created_at', ascending: false);

    return (response as List).map((json) => Event.fromJson(json)).toList();
  }
}
