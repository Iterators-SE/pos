import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../models/product.dart';

abstract class OrderScreenView {
  Order order;

  bool hasProducts;
  Widget body;

  onError();

  void addProduct(Product product);
  Function cancelOrder();
  Function processOrder();
}
