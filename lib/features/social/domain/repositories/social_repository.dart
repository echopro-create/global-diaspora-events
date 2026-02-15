import 'package:global_diaspora_events/features/events/domain/models/comment.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';

abstract class SocialRepository {
  // Comments
  Future<List<Comment>> getComments(String eventId);
  Future<void> addComment(String eventId, String text);
  Future<void> deleteComment(String commentId);

  // Following
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<bool> isFollowing(String userId);
  Future<List<String>> getFollowers(String userId);
  Future<List<String>> getFollowing(String userId);
  Future<int> getFollowersCount(String userId);
  Future<int> getFollowingCount(String userId);

  // Feed
  Future<List<Event>> getFeedEvents();
}
