import 'package:flutter/material.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/models/product.dart';

abstract class InventoryListScreenView {
  AppState state;

  Product product;

  Widget body;

  void productTilePressed(Product product);
  void onProductAdd();
  void onError();
}
