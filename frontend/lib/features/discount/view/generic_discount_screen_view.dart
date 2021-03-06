import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';

abstract class GenericDiscountScreenView {
  AppState state;
  List<Discount> discounts = [];
  List<Product> allProducts = [];
  Discount discount;

  bool isAdd = true;

  Widget body;
  String description;
  int percentage;

  List<int> includedProducts = [];

  void onError();

  void onSave({
    String description,
    List<int> includedProducts,
    int percentage,
    int id,
  });

  void onPressed();
}
