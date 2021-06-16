import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../view/generic_discount_screen_view.dart';

class GenericDiscountScreenPresenter
    extends BasePresenter<GenericDiscountScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached &&
        getView().state == AppState.done &&
        getView().discounts != null) {
      return getView().body;
    } else {
      return Center(child: Text("Something went wrong."));
    }
  }
}
