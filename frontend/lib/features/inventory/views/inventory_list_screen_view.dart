import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';

abstract class InventoryListScreenView {
  AppState state;

  List<dynamic> products = [];

  Widget body;
  String productToSearch;
  bool isSearching;

  Future<List<dynamic>> getProducts(BuildContext context);
  void onProductTilePressed({Product product, BuildContext context});
  void setProductToSearch(String name);
  void onError();
}
