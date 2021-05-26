import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../view/custom_discount_screen_view.dart';

class CustomDiscountScreenPresenter
    extends BasePresenter<CustomDiscountScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached &&
        getView().state == AppState.done &&
        getView().discounts.isNotEmpty) {
      return getView().body;
    } else {
      // return error
      return Center(child: Text("No discount found"));
    }
  }
}
