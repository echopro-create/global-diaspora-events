import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/social/data/repositories/social_repository_impl.dart';
import 'package:global_diaspora_events/features/social/domain/repositories/social_repository.dart';
import 'package:global_diaspora_events/features/events/domain/models/comment.dart';

final socialRepositoryProvider = Provider<SocialRepository>((ref) {
  return SocialRepositoryImpl(Supabase.instance.client);
});

final commentsProvider = FutureProvider.family<List<Comment>, String>((
  ref,
  eventId,
) {
  return ref.watch(socialRepositoryProvider).getComments(eventId);
});

final followersCountProvider = FutureProvider.family<int, String>((
  ref,
  userId,
) {
  return ref.watch(socialRepositoryProvider).getFollowersCount(userId);
});

final followingCountProvider = FutureProvider.family<int, String>((
  ref,
  userId,
) {
  return ref.watch(socialRepositoryProvider).getFollowingCount(userId);
});

final isFollowingProvider = FutureProvider.family<bool, String>((ref, userId) {
  return ref.watch(socialRepositoryProvider).isFollowing(userId);
});

final activityFeedProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(socialRepositoryProvider).getFeedEvents();
});
