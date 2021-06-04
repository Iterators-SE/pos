import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';

abstract class ProductDetailScreenView {
  AppState state;

  Product productData;

  Widget body;

  Future<bool> onDelete(Product product, BuildContext context);
  void updateProductData(Product product, BuildContext context);
  void onError();
}
