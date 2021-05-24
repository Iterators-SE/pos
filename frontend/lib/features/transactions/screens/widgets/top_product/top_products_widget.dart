import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../models/product.dart';
import '../../../../../repositories/transactions/interval.dart' as interval_i;
import 'top_product_widget.dart';

class TopProductsWidget extends StatelessWidget {
  final List<Product> products;
  final interval_i.Interval interval;

  const TopProductsWidget({
    Key key,
    @required this.products,
    @required this.interval,
  }) : super(key: key);

  String toSentenceCase(interval_i.Interval interval) {
    var word = interval.toString().split('.')[1];
    var letter = word[0].toUpperCase();
    return letter + word.substring(1);
  }

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
                  'Top Products of the ${toSentenceCase(interval)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              // Center this
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  semanticChildCount: products.length,
                  children: products
                      .map(
                        (e) => TopProductWidget(
                          product: e,
                          onPressed: () => print(e.name),
                        ),
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
      MaterialPageRoute(
        builder: (context) => TopProductWidget(
          product: item,
          onPressed: () => null,
        ),
      ),
    );
  }
}
