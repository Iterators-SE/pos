import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/tax.dart';

abstract class TaxListScreenView {
  AppState state;

  List<Tax> taxes = [];

  Widget body;
  String taxToSearch;
  bool isSearching;
  Tax selectedTax;

  Future<List<Tax>> getTaxes(BuildContext context);
  void selectTax(BuildContext context, Tax tax);
  void setSelectedTax(Tax tax);
  void setTaxToSearch(String name);
  void onError();
}
