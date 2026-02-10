import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';
import '../datasources/profile_remote_datasource.dart';

/// Репозиторий профиля пользователя.
class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepository(this._remoteDataSource);

  String? get currentUserId => _remoteDataSource.currentUserId;

  Future<UserProfile?> getProfile(String userId) {
    return _remoteDataSource.getProfile(userId);
  }

  Future<UserProfile> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
  }) {
    return _remoteDataSource.updateProfile(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      originCountry: originCountry,
      currentCity: currentCity,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<List<UserInterest>> getInterests(String profileId) {
    return _remoteDataSource.getInterests(profileId);
  }

  Future<UserInterest> addInterest(UserInterest interest) {
    return _remoteDataSource.addInterest(interest);
  }

  Future<void> removeInterest(String interestId) {
    return _remoteDataSource.removeInterest(interestId);
  }

  Future<List<UserInterest>> addInterestsBatch(List<UserInterest> interests) {
    return _remoteDataSource.addInterestsBatch(interests);
  }
}
