import 'package:flutter/material.dart';
import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/tax_list_screen_view.dart';

class TaxListScreenPresenter extends BasePresenter<TaxListScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached &&
        getView().state == AppState.done &&
        getView().taxes.isNotEmpty) {
      return getView().body;
    } else if (getView().state == AppState.done && getView().taxes.isEmpty) {
      return Center(child: Text("Your tax list is empty."));
    } else {
      return Center(child: Text("Oh no, an error has occured!"));
    }
  }
}
