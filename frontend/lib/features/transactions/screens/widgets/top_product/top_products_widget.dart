import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import 'top_product_widget.dart';

class TopProductsWidget extends StatelessWidget {
  final List<Product> products;

  const TopProductsWidget({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                  bottom: 20,
                ),
                child: Text(
                  'Top Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    ),
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  semanticChildCount: products.length,
                  children: products
                      .map(
                        (e) => TopProductWidget(product: e),
                      )
                      .toList(),
                ),
              ),
            ]),
          )
        : SizedBox.shrink();
  }

  void onTap(Product item, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TopProductWidget(product: item)),
    );
  }
}
