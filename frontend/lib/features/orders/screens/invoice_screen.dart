import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:meta/meta.dart';

import '../../../models/product.dart';
// import 'package:frontend/features/orders/screens/phone_number.dart';
import '../../../models/product_variant.dart';
import '../../../models/user_profile.dart';
import '../models/order.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/order_button.dart';

class InvoiceScreen extends StatefulWidget {
  final Order order;
  final List<Product> allProducts;
  final UserProfile userProfileData;

  const InvoiceScreen(
      {Key key,
      @required this.order,
      @required this.allProducts,
      @required this.userProfileData})
      : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  double amount;
  String message;

  void sendReceipt(String message, List<String> recipients) async {
    var result = await sendSMS(message: message, recipients: recipients)
        .catchError(print);
    print(result);
  }

  @override
  void initState() {
    amount = widget.order.total;

    // for (var variant in widget.order.products) {
    //   body.add(
    //     // ignore: lines_longer_than_80_chars
    //     "${getProductName(variant)} [${variant.variantName}]: \t\t ${variant.quantity}x ${variant.price}\n");
    // }

    // // ignore: lines_longer_than_80_chars
    // message =
    //   // ignore: lines_longer_than_80_chars
    //   '${widget.userProfileData.name}\n${widget.userProfileData.email}\n\nOrders:\n${body.join()}\n\nVAT:${widget.order.currentTax.percentage}%\nTotal: ${widget.order.total}\nAmount Paid: $amount\nChange:${amount - widget.order.total}\n\nThanks for ordering! ';

    // print(message);
    super.initState();
  }

  String getProductName(ProductVariant variant) {
    var product = widget.allProducts
        .where((element) => element.id == variant.productId)
        .toList();

    return product.first.name;
  }

  Future<void> showIncorrectAmount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment"),
          content: SingleChildScrollView(
              child: Text(
                  "Please enter the right amount.")),
          actions: [
            TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Future<void> showSmsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var localKey = GlobalKey<FormState>();
        var phoneNumber = "";
        var body = [];
        for (var variant in widget.order.products) {
          // ignore: lines_longer_than_80_chars
          body.add("${getProductName(variant)} [${variant.variantName}]: ${variant.quantity}x  ${variant.price}\n");
        }
        // print("body final");
        // print(body);
        // ignore: lines_longer_than_80_chars
        message = '${widget.userProfileData.name}\n${widget.userProfileData.address}\n${widget.userProfileData.email}\n\nOrders:\n${body.join()}\nTax (${widget.order.currentTax.percentage * 100}%): ${widget.order.totalAmountTax}\nTotal: ${widget.order.total + widget.order.totalAmountTax}\nAmount Paid: $amount\nChange: ${amount - widget.order.total - widget.order.totalAmountTax < 0 ? 0 : amount - widget.order.total - widget.order.totalAmountTax}\n\n${widget.userProfileData.receiptMessage} ';

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Send SMS"),
            content: SingleChildScrollView(
              child: Form(
                key: localKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: Key("customerNumber"),
                      initialValue: "$phoneNumber",
                      decoration: InputDecoration(
                        labelText: '  Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (int.tryParse(value) == null || value.length != 11) {
                          return 'Invalid Number!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        phoneNumber = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (localKey.currentState.validate()) {
                    sendReceipt(message, ['$phoneNumber']);
                    print(message);
                      return;
                    } else {
                      Navigator.of(context).pop();
                    }
                  }),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
      },
    );
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
                          ? showSmsDialog
                          : showIncorrectAmount,
                  text: "Create Receipt",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
