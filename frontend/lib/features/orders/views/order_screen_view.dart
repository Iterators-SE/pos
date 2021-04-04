import 'package:flutter/material.dart';

import '../../../models/product_variant.dart';
import '../models/order.dart';

abstract class OrderScreenView {
  Order order;

  bool hasProducts;
  Widget body;

  void onError();

  void addProduct(ProductVariant product);
  Function cancelOrder();
  Function processOrder();
}
