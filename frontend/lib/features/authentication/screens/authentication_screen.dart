import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../presenter/authentication_screen_presenter.dart';
import '../views/authentication_screen_view.dart';
import 'widgets/login_view.dart';
import 'widgets/signup_view.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    implements AuthenticationScreenView {
  AuthenticationScreenPresenter _presenter;

  @override
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  bool isLogin;

  @override
  Widget login;

  @override
  Widget signup;

  @override
  void initState() {
    _presenter = AuthenticationScreenPresenter();
    _presenter.attachView(this);

    isLogin = true;

    login = LoginWidget(
      toggle: toggleView,
      formKey: formKey,
      login: onLogin,
    );

    signup = SignupWidget(
      toggle: toggleView,
      formKey: formKey,
      signup: onSignup,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _presenter.body());
  }

  @override
  void onError(BuildContext context) {
    // TODO: implement onError
  }


  @override
  void onLogin(BuildContext context, String email, String password) async {
    var provider = Provider.of<UserProvider>(context, listen: false);

    // print('here');
    await provider.login(context, email: email, password: password);

    // print(provider.user);
    // print(provider.signedUp);
  }

  @override
  void onSignup(
      BuildContext context, String email, String name, String password) async {
    var provider = Provider.of<UserProvider>(context, listen: false);
    await provider.signup(context,
        name: name, email: email, password: password);

    // provider.signedUp ?
  }

  @override
  void toggleView() {
    setState(() {
      formKey.currentState.reset();
      isLogin = !isLogin;
    });
  }
}
