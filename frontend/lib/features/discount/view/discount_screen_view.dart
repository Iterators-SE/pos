import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';

abstract class DiscountScreenView {
  AppState state;
  List<Discount> discounts = [];
  List<Product> products = [];

  Widget body;

  void onError();
  Future<Either<Failure, List<Discount>>> getDiscounts();
  Future<Either<Failure, List<Product>>> getProducts();
}
