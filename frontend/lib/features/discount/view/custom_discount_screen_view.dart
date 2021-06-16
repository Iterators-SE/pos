import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';

abstract class CustomDiscountScreenView {
  AppState state;
  List<Discount> discounts = [];
  Discount discount;

  bool isAdd = true;

  Widget body;
  String description;
  int percentage;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime startDate;
  DateTime endDate;

  List<int> includedProducts = [];
  List<Product> allProducts = [];

  String formatTime(String time);

  void setStartDate(DateTime dateTime);

  void setEndDate(DateTime dateTime);

  void setStartTime(TimeOfDay time);

  void setEndTime(TimeOfDay time);

  void onError();

  void onSave();

  void onPressed();
}
