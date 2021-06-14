import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import '../core/error/failure.dart';
import '../models/user.dart';
import '../repositories/authentication/authentication_repository_implementation.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  String _token;
  Either<Failure, bool> _signedUp;
  Either<Failure, User> _loggedIn;

  // final HttpLink _httpLink = HttpLink('http://localhost:5000/graphql'); // WEB
    // final String _devUri = 'http://localhost:5000/graphql';
  // final String _prodUri = 'http://iterators-pos.herokuapp.com/graphql';
  // String uri = kReleaseMode ? _prodUri : _devUri;
  final HttpLink _httpLink = HttpLink('http://10.0.2.2:5000/graphql'); // ANDROID


  String get token => _token;
  User get user => _user;
  Either<Failure, bool> get signedUp => _signedUp;
  Either<Failure, User> get loggedIn => _loggedIn;

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

    _loggedIn = data;

    if (data.isRight) {
      data.fold((error) => null, (user) {
        token = user.token;
      });
    }
    notifyListeners();
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
    var data =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .logout();

    if (data.isRight) {
      _user = null;
      _token = null;
      notifyListeners();
    }
  }

  Link get link => _token != null
      ? AuthLink(getToken: () => 'Bearer $token').concat(_httpLink)
      : _httpLink;
}
