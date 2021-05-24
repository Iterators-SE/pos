import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../../../../models/product.dart';

class GenericViewWidget extends StatelessWidget {
  final List<Product> products;

  const GenericViewWidget({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: Make resizeable? or scrollable?
      // Idea: Make horizontal list view with one element?
      height: 200,
      width: 400,
      child: Chart(
        // data: [
        //   {'genre': 'Sports', 'sold': 275},
        //   {'genre': 'Strategy', 'sold': 115},
        //   {'genre': 'Action', 'sold': 120},
        //   {'genre': 'Shooter', 'sold': 350},
        //   {'genre': 'Other', 'sold': 150},
        // ],
        data: products
            .map((e) => {'product': e.name, 'sold': e.quantity})
            .toList(),
        scales: {
          'product': CatScale(
            accessor: (map) => map['product'] as String,
          ),
          // 'genre': CatScale(
          //   accessor: (map) => map['genre'] as String,
          // ),
          'sold': LinearScale(
            accessor: (map) => map['sold'] as num,
            nice: true,
          )
        },
        geoms: [
          IntervalGeom(
            position: PositionAttr(field: 'product*sold'),
            // position: PositionAttr(field: 'genre*sold'),
          )
        ],
        axes: {
          // 'genre': Defaults.horizontalAxis,
          'product': Defaults.horizontalAxis,
          'sold': Defaults.verticalAxis,
        },
      ),
    );
  }
}
