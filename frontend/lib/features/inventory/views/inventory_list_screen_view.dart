import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/product.dart';

abstract class InventoryListScreenView {
  AppState state;

  List<Product> products = [];

  Widget body;
  String productToSearch;
  bool isSearching;

  Future<Either<Failure, List<Product>>> getProducts(BuildContext context);
  void onProductTilePressed({Product product, BuildContext context});
  void setProductToSearch(String name);
  void onError();
}
