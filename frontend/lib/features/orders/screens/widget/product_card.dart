import 'package:flutter/material.dart';
import '../../../../models/product_variant.dart';

class ProductCard extends StatelessWidget {
  final ProductVariant product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/Xpos.png'),
      ),
      title: Text("${product.productId} [${product.variantName}]"),
    );
  }
}
