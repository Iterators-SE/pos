import '../../database/local/local_database.dart';

class ProfileLocalDataSource {
  final AppDatabase local;
  ProfileLocalDataSource({this.local});

  Future<void> cacheProfileInfo(dynamic data) async {
    final UserProfile userProfile = data.map((userProfile) {
      return UserProfile(
        id: userProfile['id'],
        name: userProfile['name'],
        email: userProfile['email'],
        receiptMessage: userProfile['receiptMessage'],
        address: userProfile['address'],
      );
    });
    await local.addProfileInfo(userProfile);
  }

  Future<UserProfile> getProfileInfo()async {
    return await local.getProfileInfo();
  }
}
