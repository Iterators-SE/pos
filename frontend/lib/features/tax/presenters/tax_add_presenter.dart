import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/tax_add_screen_view.dart';

class AddTaxScreenPresenter extends BasePresenter<AddTaxScreenView> {
  Widget body(BuildContext context) {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached && getView().state == AppState.done) {
      return getView().body;
    } else if (isViewAttached && getView().state == AppState.successful) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Tax has been added!"),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
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
