
import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/inventory_list_screen_view.dart';

class InventoryListScreenPresenter 
  extends BasePresenter<InventoryListScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached &&
        getView().state == AppState.done &&
        getView().products != null &&
        getView().products.isNotEmpty) {
      return getView().body;
    } else {
      return Center(child: Text("Your inventory is empty."));
    }
  }
}
