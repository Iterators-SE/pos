import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../repositories/authentication_repository_implementation.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  String _token;

  String get token => _token;
  User get user => _user;

  void login(BuildContext context, {String email, String password}) async {
    var data = await Provider.of<AuthenticationRepository>(context).login(
      email: email,
      password: password,
    );

    if (data.isRight) {
      _user = data.fold((error) => null, (user) => user);
      notifyListeners();
    }

    // show visual indication that something went wrong ?
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
