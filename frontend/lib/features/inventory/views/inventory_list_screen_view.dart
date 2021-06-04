import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/models/product.dart';

abstract class InventoryListScreenView {
  AppState state;

  List<Product> products = [];

  Widget body;
  String productToSearch;
  bool isSearching;

  Future<List<Product>> getProducts(BuildContext context);
  void onProductTilePressed({Product product, BuildContext context});
  void setProductToSearch(String name);
  void onError();
}
