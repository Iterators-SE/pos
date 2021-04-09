import '../../models/user.dart';

abstract class IAuthenticationDataSource {
  Future<dynamic> getUser();
  Future<bool> signup({String name, String email, String password});
  Future<User> login({String email, String password});
  Future<void> logout();
}
