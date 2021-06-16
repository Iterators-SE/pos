import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../../../../models/product.dart';

class GenericViewWidget extends StatelessWidget {
  final List<Product> products;

  const GenericViewWidget({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Chart(
          data: products
              .map((e) => {'product': e.name, 'sold': e.quantity})
              .toList(),
          scales: {
            'product': CatScale(
              accessor: (map) => map['product'] as String,
            ),
            'sold': LinearScale(
              accessor: (map) => map['sold'] as num,
              nice: true,
            )
          },
          geoms: [
            IntervalGeom(
              position: PositionAttr(field: 'product*sold'),
            )
          ],
          axes: {
            'product': Defaults.horizontalAxis,
            'sold': Defaults.verticalAxis,
          },
        ),
        ),
      ),
    );
  }
}
