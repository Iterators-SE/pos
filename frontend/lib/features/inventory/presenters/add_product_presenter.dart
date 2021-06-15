import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.pop(context, AppState.successful);
      });

      // return Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       // Center(
      //       //   child: Image(
      //       //   image: AssetImage(
      //       //   'images/blue_added.png',),
      //       //     width: 150,
      //       //     height: 160,
      //       //   )
      //       // ), 
      //       Align(
      //         alignment: Alignment.center, 
      //         child: Text("Product added to inventory"),
      //       ),
      //       SizedBox(height: 30),
      //       ElevatedButton(
      //           onPressed: () async {
      //             Navigator.pop(context);
      //           },
      //           child: Text("Okay"))
      //     ],
      //   ),
      // );
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context, AppState.error);
      });
    }
  }
}
