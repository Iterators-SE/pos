import '../../models/user_profile.dart';

abstract class IProfileRemoteDataSource {
  Future<dynamic> getProfileInfo();
  Future<UserProfile> updateProfileInfo(UserProfile userProfile);
}