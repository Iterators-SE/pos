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
        getView().products.isNotEmpty) {
      return getView().body;
    } else {
      print(getView().state);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(
            //   child: Image(
            //   image: AssetImage(
            //   'images/empty_inventory.png',),
            //     width: 150,
            //     height: 160,
            //   )
            // ), 
            Align(
              alignment: Alignment.center, 
              child:Text("Your inventory is empty"),
            ),
          ],
        ),
      );
    }
  }
}
 