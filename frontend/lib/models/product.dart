import 'package:frontend/models/product_variant.dart';

class Product {
  int id;
  int quantity;
  List<ProductVariant> variants = [];
  String name;
  double discount;

  // make required
  Product({
    this.id,
    this.name,
    this.variants = const [],
    this.discount = 0,
  }) {
    quantity = variants.fold(
      0,
      (previousValue, item) => previousValue + item.quantity ?? 0,
    );
  }
}
