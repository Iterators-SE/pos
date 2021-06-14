import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/authentication_screen_view.dart';

class AuthenticationScreenPresenter
    extends BasePresenter<AuthenticationScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached) {
      return Stack(
        children: [
          getView().isLogin ? getView().login : getView().signup,
          getView().appState == AppState.loading
              ? Container(
                  height: double.maxFinite,
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(
                        // color: xposGreen[50],
                        ),
                  ),
                )
              : SizedBox.shrink()
        ],
      );
    }

    return Container();
  }
}
