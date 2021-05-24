import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/product.dart';
import '../models/order.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/order_button.dart';

class InvoiceScreen extends StatelessWidget {
  final Order order;
  final List<Product> allProducts;

  const InvoiceScreen({
    Key key,
    @required this.order,
    this.allProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'INVOICE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
              CustomDataTable(
                order: order,
                onPressed: null,
                showEdit: false,
              ),
              CustomDataTable(
                order: order,
                onPressed: () => (productVariant) async => await showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        chosenProduct: allProducts.firstWhere(
                          (e) => e.id == productVariant.productID,
                        ),
                        quantity: productVariant.quantity,
                        chosenVariant: productVariant.variantName,
                        allProducts: allProducts,
                      ),
                    ),
                columns: [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text(''), numeric: true),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text("Price")),
                      DataCell(
                        Text(
                          order.total.toString(),
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("Discount")),
                      DataCell(
                        Text(
                          "0",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("VAT")),
                      DataCell(
                        Text(
                          "0",
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("Total")),
                      DataCell(
                        Text(
                          '${order.total + 0}', // discount
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("Cash Tendered")),
                      DataCell(
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: '130',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("Change")),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text("This serves as an official receipt"),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [OrderButton(onPressed: null, text: "Print")],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
