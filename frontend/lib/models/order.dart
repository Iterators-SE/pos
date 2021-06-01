import 'package:meta/meta.dart';

import 'product.dart';
import 'product_variant.dart';

class Order {
  final int id;
  final Product product;
  final ProductVariant variant;
  final int quantity;

  const Order({
    @required this.id,
    @required this.product,
    @required this.variant,
    @required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        variant: ProductVariant.fromJson(json["variant"], 
        int.parse(json["product"]['id'])),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.id,
        "variant": variant.variantId,
        "quantity": quantity
      };

  @override
  String toString() {
    return 'Order - $id; quantity: $quantity;';
  }
}
