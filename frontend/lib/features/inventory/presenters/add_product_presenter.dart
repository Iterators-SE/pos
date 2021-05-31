import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/screens/add_product_screen.dart';
import 'package:frontend/features/inventory/screens/inventory_list_screen.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:provider/provider.dart';
import '../../../core/presenters/base_presenter.dart';

import '../../../core/state/app_state.dart';
import '../views/add_product_screen_view.dart';

class AddProductScreenPresenter extends BasePresenter<AddProductScreenView> {
  Widget body(BuildContext context) {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached && getView().state == AppState.done) {
      return getView().body;
    } else if (isViewAttached && getView().state == AppState.successful) {
      return Center(
        child: Column(
          children: [
            Text("Product Successfully added to your inventory"),
            ElevatedButton(
                onPressed: () async {
              
                },
                child: Text("Okay"))
          ],
        ),
      );
    } else {
      return Center(child: Text("Oh no, there's a problem!"));
    }
  }
}
