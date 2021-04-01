import 'package:flutter/material.dart';
import '../../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO: Update or Remove as Needed
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/Xpos.png'),
      ),
      title: Text("${product.name} [${product.variant}]"),
    );
  }
}
