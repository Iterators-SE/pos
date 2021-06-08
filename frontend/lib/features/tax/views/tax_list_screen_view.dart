import 'package:flutter/material.dart';
import '../../../core/state/app_state.dart';
import '../../../models/tax.dart';

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
