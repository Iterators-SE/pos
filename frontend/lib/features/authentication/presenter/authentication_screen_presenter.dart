import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../views/authentication_screen_view.dart';

class AuthenticationScreenPresenter
    extends BasePresenter<AuthenticationScreenView> {
  Widget body() {
    checkViewAttached();
    return isViewAttached && getView().isLogin
        ? getView().login
        : getView().signup;
  }
}
