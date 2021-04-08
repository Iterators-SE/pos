import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../repositories/authentication/authentication_repository_implementation.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  String _token;
  Either<Failure, bool> _signedUp;

  String get token => _token;
  User get user => _user;
  bool get signedUp => _signedUp;

  void login(BuildContext context, {String email, String password}) async {
    var data =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .login(
      email: email,
      password: password,
    );

    if (data.isRight) {
      _user = data.fold((error) => null, (user) => user);
      notifyListeners();
    }

    // show visual indication that something went wrong ?
  }

  void signup(BuildContext context,
      {String name, String email, String password}) async {
    var data =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .signup(
      name: name,
      email: email,
      password: password,
    );

    _signedUp = data;
      notifyListeners();
  }

  void logout(BuildContext context) async {
    var data = await Provider.of<AuthenticationRepository>(context).logout();

    if (data.isRight) {
      _user = null;
      notifyListeners();
    }

    // show visual indication that something went wrong ?
  }
}
