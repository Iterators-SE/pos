
import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/product_details_screen_view.dart';

class ProductDetailScreenPresenter
  extends BasePresenter<ProductDetailScreenView> {
  Widget body(BuildContext context) {

    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached &&
        getView().state == AppState.done) {
      return getView().body;
    } else if(getView().state == AppState.successful && isViewAttached){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image(
              image: AssetImage(
              'images/blue_deleted.png',),
                width: 170,
                height: 180,
              )
            ), 
            Align(
              alignment: Alignment.center, 
              child: Text("Product has been deleted"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text("Okay")
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("An error has occured during deletion."),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text("Okay")
            ),
          ],
        ),
      );
    }
  }
}
