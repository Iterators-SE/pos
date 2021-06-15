import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/presenters/base_presenter.dart';
import '../../../core/state/app_state.dart';
import '../views/edit_details_screen_view.dart';

class EditDetailScreenPresenter extends BasePresenter<EditDetailScreenView> {
  Widget body(BuildContext context) {
    checkViewAttached();

    if (isViewAttached && getView().state == AppState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached && getView().state == AppState.done) {
      return getView().body;
    } else if(getView().state == AppState.successful && isViewAttached){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image(
              image: AssetImage(
              'images/blue_edited.png',),
                width: 150,
                height: 160,
              )
            ), 
            Align(
              alignment: Alignment.center, 
              child: Text("Product has been updated"),
            ),
            ElevatedButton(
                onPressed: () {
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
            Text("An error has occured during update."),
            ElevatedButton(
                onPressed: () {
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
