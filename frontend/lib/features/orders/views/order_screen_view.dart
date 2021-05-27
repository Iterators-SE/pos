import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../models/order.dart';

abstract class OrderScreenView {
  Order order;
  AppState state;

  List<Product> allProducts;

  bool hasProducts;

  Widget body;
  Failure failure;


  void addProduct(ProductVariant product);

  Function addDiscount();

  Future<Either<Failure, List<Product>>> getProducts();

  Function cancelOrder();

  Function processOrder();
}
