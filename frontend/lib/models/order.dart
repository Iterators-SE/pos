import 'dart:collection';

import 'product.dart';

// TODO: Transform to ChangeNotifier
class Order {
  final List<Product> _products = [];

  void addProduct(Product product) => _products.add(product);
  void editProduct(Product product) {
    var index = _products.indexWhere((element) => element.id == product.id);

    if (index != -1) {
      _products[index] = product;
    }
  }

  List<Product> get products => UnmodifiableListView(_products);

  double get total {
    return _products.fold(
        0, (prev, next) => prev + next.quantity * next.basePrice);
  }
}
