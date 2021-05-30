import 'dart:collection';

import '../../../models/discounts.dart';
import '../../../models/product_variant.dart';

class Order {
  final List<ProductVariant> _products = [];
  final List<Discount> _discounts = [];

  List<ProductVariant> get products => UnmodifiableListView(_products);
  List<Discount> get discounts => UnmodifiableListView(_discounts);

  void addProduct(ProductVariant product) {
    var index = _products.indexWhere(
      (element) =>
          element.productId == product.productId &&
          element.variantName == product.variantName,
    );

    index == -1 ? _products.add(product) : editProduct(product);
  }

  void addDiscount(List<Discount> discounts) {
    _discounts.removeRange(0, _discounts.length);
    _discounts.addAll(discounts);
  }

  void editProduct(ProductVariant product) {
    var index = _products.indexWhere(
      (element) =>
          element.productId == product.productId &&
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

  double get discountTotal {
    var sum = 0.0;

    var applicableProducts = Set.of(_products.where((element) => _discounts
        .map((e) => e.products)
        .expand((e) => e)
        .toList()
        .contains(element.productId))).toList();

    for (var i = 0; i < _discounts.length; i++) {
      sum += applicableProducts.fold(
        0,
        (prev, next) => _discounts[i].products.contains(next.productId)
            ? next.price * next.quantity * (_discounts[i].percentage / 100) +
                prev
            : prev,
      );
    }

    return sum;
  }

  double get total {
    return _products.fold(0, (prev, next) => prev + next.quantity * next.price);
  }
}
