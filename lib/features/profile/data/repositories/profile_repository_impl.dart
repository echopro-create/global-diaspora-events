import 'package:global_diaspora_events/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_interest.dart';
import 'package:global_diaspora_events/features/profile/domain/entities/user_profile.dart';
import 'package:global_diaspora_events/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserProfile> getProfile(String userId) async {
    return await _remoteDataSource.getProfile(userId);
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    await _remoteDataSource.updateProfile(profile);
  }

  @override
  Future<List<UserInterest>> getInterests() async {
    return await _remoteDataSource.getInterests();
  }

  @override
  Future<void> updateUserInterests(
    String userId,
    List<String> interestIds,
  ) async {
    await _remoteDataSource.updateUserInterests(userId, interestIds);
  }
}
