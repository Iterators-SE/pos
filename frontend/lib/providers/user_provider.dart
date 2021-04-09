import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/error/failure.dart';
import '../models/user.dart';
import '../repositories/authentication/authentication_repository_implementation.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  String _token;
  Either<Failure, bool> _signedUp;

  String get token => _token;
  User get user => _user;
  Either<Failure, bool> get signedUp => _signedUp;

  set token(String token) {
    _user = User(token: token);
    _token = token;
    notifyListeners();
  }

  void login(BuildContext context, {String email, String password}) async {
    var data =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .login(
      email: email,
      password: password,
    );

    if (data.isRight) {
      data.fold((error) => null, (user) {
        token = user.token;
      });
      notifyListeners();
    }
  }

  void signup(BuildContext context,
      {String name, String email, String password}) async {
    print('Hi');
    // var data =
    //     await Provider.of<AuthenticationRepository>(context, listen: false)
    //         .signup(
    //   name: name,
    //   email: email,
    //   password: password,
    // );

    // _signedUp = data;
    // notifyListeners();
  }

  void logout(BuildContext context) async {
    var data =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .logout();

    if (data.isRight) {
      _user = null;
      _token = null;
      notifyListeners();
    }
  }
}
