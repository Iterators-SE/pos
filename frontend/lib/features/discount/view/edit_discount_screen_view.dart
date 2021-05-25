import 'package:flutter/material.dart';

import '../../../models/product.dart';
import 'discount_screen_view.dart';

abstract class EditDiscountScreenView implements DiscountScreenView {
  void editDiscount();

  Future<List<Product>> getProducts();

  void setStartDate(DateTime dateTime);

  void setEndDate(DateTime dateTime);

  void setStartTime(TimeOfDay time);

  void setEndTime(TimeOfDay time);
}
