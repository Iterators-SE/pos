import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';

abstract class DiscountScreenView {
  AppState state;
  List<Discount> discounts = [];

  Widget body;

  void onError();
  Future<Either<Failure, List<Discount>>> getDiscounts();
}
