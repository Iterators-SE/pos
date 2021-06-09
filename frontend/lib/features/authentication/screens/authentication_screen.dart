import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../providers/user_provider.dart';
import '../presenter/authentication_screen_presenter.dart';
import '../views/authentication_screen_view.dart';
import 'login_view.dart';
import 'signup_view.dart';

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
  AppState appState = AppState.done;

  @override
  Failure error;

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
      login: () => onLogin,
    );

    signup = SignupWidget(
      toggle: toggleView,
      formKey: formKey,
      signup: () => onSignup,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _presenter.body());
  }

  @override
  void onError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.message)),
    );
  }

  @override
  void onLogin(BuildContext context, String email, String password) async {
    setState(() => appState = AppState.loading);
    var provider = Provider.of<UserProvider>(context, listen: false);
    await provider.login(context, email: email, password: password);

    setState(() => appState = AppState.done);

    var data = provider.loggedIn;
    var right = provider.loggedIn.fold(
      (failure) => failure,
      (success) => success,
    );

    if (data.isLeft) {
      setState(() => error = right);
      onError(context);
    }
  }

  @override
  void onSignup(
      BuildContext context, String email, String name, String password) async {
    setState(() => appState = AppState.loading);

    var provider = Provider.of<UserProvider>(context, listen: false);
    await provider.signup(
      context,
      name: name,
      email: email,
      password: password,
    );

    setState(() => appState = AppState.done);

    var data = provider.signedUp;
    var right = provider.signedUp.fold(
      (failure) => failure,
      (success) => success,
    );

    if (data.isLeft) {
      setState(() => error = right);
      onError(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Don't forget to validate your account by checking your email!"),
        ),
      );
    }
  }

  @override
  void toggleView() {
    setState(() {
      formKey.currentState.reset();
      isLogin = !isLogin;
    });
  }
}
