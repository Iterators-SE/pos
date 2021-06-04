import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';

abstract class ProductDetailScreenView {
  AppState state;

  Product product;

  Widget body;

  Future<bool> onDelete(Product product, BuildContext context);
  void onEdit(Product product);
  void onError();
}
