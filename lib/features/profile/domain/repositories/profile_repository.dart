import 'package:global_diaspora_events/features/profile/domain/entities/user_profile.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_interest.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile(String userId);
  Future<void> updateProfile(UserProfile profile);
  Future<List<UserInterest>> getInterests();
  Future<void> updateUserInterests(String userId, List<String> interestIds);
}
