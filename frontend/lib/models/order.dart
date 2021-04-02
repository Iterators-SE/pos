import 'dart:collection';

import 'product_variant.dart';

// TODO: Transform to ChangeNotifier
class Order {
  final List<ProductVariant> _products = [];

  void addProduct(ProductVariant product) => _products.add(product);
  void editProduct(ProductVariant product) {
    var index = _products.indexWhere((element) => element.id == product.id);

    if (index != -1) {
      _products[index] = product;
    }
  }

  List<ProductVariant> get products => UnmodifiableListView(_products);

  double get total {
    return _products.fold(
        0, (prev, next) => prev + next.quantity * next.basePrice);
  }
}
