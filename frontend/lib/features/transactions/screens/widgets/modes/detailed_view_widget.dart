import 'package:flutter/material.dart';
import '../../../../../models/product.dart';

class DetailedViewWidget extends StatelessWidget {
  final List<Product> products;

  const DetailedViewWidget({Key key, this.products}) : super(key: key);

  // String getPopularVariantData(Product product) {
  //   var variants = product.variants;

  //   print(variants);
  //   print(variants.first.quantity);
  //   print('VAR');
  //   print(product);
  //   print('PRODUCT');
  //   variants?.sort((a, b) => b.quantity.compareTo(a.quantity));
  //   return variants.first.variantName;
  // }

// TODO: swap w/ CDT [order/widget]
// TODO: ADD ROW PER VARIANT
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Product")),
        DataColumn(label: Text("Quantity Sold"), numeric: true),
        // DataColumn(label: Text("Most Popular Variant"), numeric: true),
        DataColumn(label: Text("Total"), numeric: true)
      ],
      rows: products.isNotEmpty
          ? products
              ?.map(
                (e) => DataRow(
                  cells: [
                    DataCell(Text('${e.name}')),
                    DataCell(Text('${e.quantity}')),
                    // DataCell(Text(getPopularVariantData(e))),
                    DataCell(Text('${e.quantity}')), // Dummy
                  ],
                ),
              )
              ?.toList()
          : <DataRow>[],
    );
  }
}
