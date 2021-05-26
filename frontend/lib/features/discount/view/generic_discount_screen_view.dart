import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';

abstract class GenericDiscountScreenView {
  AppState state;
  List<Discount> discounts = [];

  bool isAdd = true;

  Widget body;
  String description;
  int percentage;

  List<int> includedProducts = [];

  void onError();

  void onSave();

  void onPressed();
}
