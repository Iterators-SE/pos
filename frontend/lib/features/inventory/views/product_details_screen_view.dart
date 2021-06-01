import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/models/product.dart';

abstract class ProductDetailScreenView {
  AppState state;

  Product product;

  Widget body;

  Future<bool> onDelete(Product product, BuildContext context);
  void onEdit(Product product);
  void onError();
}
