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
        ? Container(
          //color: Colors.white,
           margin: const EdgeInsets.only(bottom: 4.0),
           decoration: BoxDecoration(
             color: Colors.white,
            boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(5.0, 8.0),
                  blurRadius: 7.0,
                  spreadRadius: 1.50)
                ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          //   border: Border(
          //   bottom: BorderSide(color: xposGreen[300]),
          // )
        ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Top Products of the ${toSentenceCase(interval)}',
                        style: TextStyle(
                          fontFamily: "Montserrat Superbold",
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
