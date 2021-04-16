import 'package:flutter/material.dart';

abstract class AuthenticationScreenView {
  GlobalKey<FormState> formKey;

  bool isLogin = true;

  Widget login;
  Widget signup;

  void onError(BuildContext context);

  void onSignup(
    BuildContext context,
    String email,
    String name,
    String password,
  );

  void onLogin(BuildContext context, String email, String password);

  void toggleView();
}
