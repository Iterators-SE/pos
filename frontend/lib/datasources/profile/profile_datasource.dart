import '../../models/user_profile.dart';

abstract class IProfileRemoteDataSource {
  Future<UserProfile> getProfileInfo();
  Future<UserProfile> updateProfileInfo(UserProfile userProfile);
}