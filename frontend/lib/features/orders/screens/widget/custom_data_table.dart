import 'package:flutter/material.dart';
import '../../../../models/product.dart';

import '../../models/order.dart';

class CustomDataTable extends StatefulWidget {
  final Order order;
  final List<Product> products;
  final Function onPressed;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final bool showEdit;

  CustomDataTable(
      {Key key,
      this.order,
      this.onPressed,
      this.products,
      this.columns = const [
        DataColumn(label: Text("Product")),
        DataColumn(label: Text("Quantity"), numeric: true),
        DataColumn(label: Text("Price"), numeric: true),
        DataColumn(label: Text("Total"), numeric: true)
      ],
      this.rows,
      this.showEdit = true})
      : super(key: key);

  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    print("Products in custom data table");
    print(widget.products);
    return DataTable(
      columns: widget.columns,
      rows: widget.rows ??
          widget.order.products
              .map(
                (e) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        // ignore: lines_longer_than_80_chars
                        '${widget.products.where((element) => element.id == e.productId).toList()[0].name} [${e.variantName}]',
                      ),
                    ),
                    DataCell(
                      Text('${e.quantity}'),
                      showEditIcon: widget.showEdit,
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
