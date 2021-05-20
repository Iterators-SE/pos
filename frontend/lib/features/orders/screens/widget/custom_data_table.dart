import 'package:flutter/material.dart';

import '../../models/order.dart';

class CustomDataTable extends StatefulWidget {
  final Order order;
  final Function onPressed;
  final List<DataColumn> columns;
  final List<DataRow> rows;

  CustomDataTable({
    Key key,
    this.order,
    this.onPressed,
    this.columns = const [
      DataColumn(label: Text("Product")),
      DataColumn(label: Text("Quantity"), numeric: true),
      DataColumn(label: Text("Price"), numeric: true),
      DataColumn(label: Text("Total"), numeric: true)
    ],
    this.rows,
  }) : super(key: key);

  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: widget.columns,
      rows: widget.rows ?? widget.order.products
          .map(
            (e) => DataRow(
              cells: [
                DataCell(
                  Text('${e.productId} [${e.variantName}]'),
                ),
                DataCell(
                  Text('${e.quantity}'),
                  showEditIcon: true,
                  onTap: () => widget.onPressed()(e),
                ),
                DataCell(
                  Text('${e.price}'),
                ),
                DataCell(
                  Text('${e.quantity * e.price}'),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
