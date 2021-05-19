import 'package:flutter/material.dart';
import '../../../../../models/product.dart';

class DetailedViewWidget extends StatelessWidget {
  final List<Product> products;

  const DetailedViewWidget({Key key, this.products}) : super(key: key);

  String getPopularVariantData(Product product) {
    var variants = product.variants;
    variants.sort((a, b) => b.quantity - a.quantity);
    return variants.first.variantName;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Product")),
        DataColumn(label: Text("Quantity Sold"), numeric: true),
        DataColumn(label: Text("Most Popular Variant"), numeric: true),
        DataColumn(label: Text("Total"), numeric: true)
      ],
      rows: products
          .map(
            (e) => DataRow(
              cells: [
                DataCell(Text('${e.name}')),
                DataCell(Text('${e.quantity}')),
                DataCell(Text(getPopularVariantData(e))),
                DataCell(Text('${e.quantity * e.variants.last.price}')),
              ],
            ),
          )
          .toList(),
    );
  }
}
