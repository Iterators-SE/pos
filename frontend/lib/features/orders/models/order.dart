import 'dart:collection';

import '../../../models/product_variant.dart';

// TODO: Transform to ChangeNotifier
class Order {
  final List<ProductVariant> _products = [];

  void addProduct(ProductVariant product) => _products.add(product);
  void editProduct(ProductVariant product) {
    var index = _products.indexWhere(
      (element) =>
          element.productID == product.productID &&
          element.variantName == product.variantName,
    );

    if (index != -1) {
      product.quantity > 0
          ? _products[index] = product
          : _products.removeAt(index);
    } else {
      addProduct(product);
    }
  }

  List<ProductVariant> get products => UnmodifiableListView(_products);

  double get total {
    return _products.fold(
        0, (prev, next) => prev + next.quantity * next.price);
  }
}
