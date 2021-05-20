import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import '../../../../../models/product_variant.dart';
import '../modes/mode_view.dart';
import '../top_product/top_products_widget.dart';

class MonthViewWidget extends StatelessWidget {
  final fakeProducts = [
    Product(id: 1, name: 'Olympian Cappucino', variants: [
      ProductVariant(
          variantId: 1,
          variantName: 'Small',
          quantity: 10,
          productId: 1,
          price: 100)
    ]),
    Product(id: 2, name: 'Kapa-Kappucino', variants: [
      ProductVariant(
          variantId: 2,
          variantName: 'Small',
          quantity: 50,
          productId: 1,
          price: 100)
    ]),
    Product(id: 3, name: 'Donut', variants: [
      ProductVariant(
          variantId: 3,
          variantName: 'Regular',
          quantity: 100,
          productId: 1,
          price: 100)
    ])
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Make infinitely scrollable
        return Column(
        children: [
          Expanded(
            child: TopProductsWidget(products: fakeProducts),
          ),
          ModeView(products: fakeProducts),
        ],
      
    );
  }
}
