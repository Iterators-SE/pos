import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';

abstract class AuthenticationScreenView {
  GlobalKey<FormState> formKey;
  AppState appState;
  Failure error;

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
