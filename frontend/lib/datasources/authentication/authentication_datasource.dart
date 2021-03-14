import '../../models/user.dart';

abstract class IAuthenticationDataSource {
  Future<bool> signup(
      {String name, String email, String password});
  Future<User> login({String email, String password});
  Future<bool> logout();
}