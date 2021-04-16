import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../views/home_screen_view.dart';

class HomeScreenPresenter extends BasePresenter<HomeScreenView> {
  void navigate(BuildContext context, MaterialPageRoute route) {
    Navigator.push(context, route);
  }
}
