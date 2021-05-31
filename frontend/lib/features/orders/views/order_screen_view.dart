import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../models/order.dart';

abstract class OrderScreenView {
  Order order;
  AppState state;

  List<Product> allProducts;
  List<Discount> allDiscounts;

  bool hasProducts;

  Widget body;
  Failure failure;


  void addProduct(ProductVariant product);

  void addDiscount(List<Discount> discounts);

  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, List<Discount>>> getDiscounts();

  Function cancelOrder();

  Function processOrder();
}
