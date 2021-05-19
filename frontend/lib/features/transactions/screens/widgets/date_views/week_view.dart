import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import '../../../../../models/product_variant.dart';
import '../modes/mode_view.dart';
import '../top_product/top_products_widget.dart';

class WeekViewWidget extends StatelessWidget {
  final fakeProducts = [
    Product(id: 1, name: 'Olympian Cappucino', variants: [
      ProductVariant(
          variantid: 1,
          variantName: 'Small',
          quantity: 10,
          productID: 1,
          price: 100)
    ]),
    Product(id: 2, name: 'Kapa-Kappucino', variants: [
      ProductVariant(
          variantid: 2,
          variantName: 'Small',
          quantity: 50,
          productID: 1,
          price: 100)
    ]),
    Product(id: 3, name: 'Donut', variants: [
      ProductVariant(
          variantid: 3,
          variantName: 'Regular',
          quantity: 100,
          productID: 1,
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
