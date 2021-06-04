import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/product.dart';
import '../models/order.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/order_button.dart';

class InvoiceScreen extends StatefulWidget {
  final Order order;
  final List<Product> allProducts;

  const InvoiceScreen({
    Key key,
    @required this.order,
    @required this.allProducts,
  }) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  double amount;

  @override
  void initState() {
    amount = widget.order.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.order.products);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
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
              products: widget.allProducts,
              order: widget.order,
              onPressed: null,
              showEdit: false,
            ),
            CustomDataTable(
              order: widget.order,
              products: widget.allProducts,
              onPressed: () => (productVariant) async => await showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      chosenProduct: widget.allProducts.firstWhere(
                        (e) => e.id == productVariant.productId,
                      ),
                      quantity: productVariant.quantity,
                      chosenVariant: productVariant.variantName,
                      allProducts: widget.allProducts,
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
                        widget.order.total.toString(),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Discount")),
                    DataCell(
                      Text(
                        widget.order.discountTotal.toString(),
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("VAT")),
                    DataCell(
                      Text(
                        "${widget.order.currentTax.percentage * 100}%",
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Total")),
                    DataCell(
                      Text(
                        // ignore: lines_longer_than_80_chars
                        '${widget.order.total - widget.order.discountTotal + widget.order.totalAmountTax}',
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
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // ignore: lines_longer_than_80_chars
                          if (double.tryParse(value) >=
                              widget.order.total +
                                  widget.order.totalAmountTax) {
                            setState(() => amount = double.tryParse(value) ??
                                widget.order.total +
                                    widget.order.totalAmountTax);
                          }
                        },
                        validator: (value) {
                          if (double.tryParse(value) != null &&
                              double.parse(value) >= widget.order.total) {
                            return null;
                          }

                          return "Insufficient amount";
                        },
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Change")),
                    DataCell(
                      Text(
                        // ignore: lines_longer_than_80_chars
                        '${amount - widget.order.total - widget.order.totalAmountTax < 0 ? 0 : amount - widget.order.total - widget.order.totalAmountTax}',
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
              children: [
                OrderButton(
                  onPressed:
                      amount >= widget.order.total + widget.order.totalAmountTax
                          ? () {
                              print("Order Complete!");
                            }
                          : () {
                              print("Not Complete!");
                            },
                  text: "Print",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
