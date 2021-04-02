import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../models/product_variant.dart';

abstract class OrderScreenView {
  Order order;

  bool hasProducts;
  Widget body;

  void onError();

  void addProduct(ProductVariant product);
  Function cancelOrder();
  Function processOrder();
}
