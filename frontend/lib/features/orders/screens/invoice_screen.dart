import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
// import 'package:frontend/repositories/transactions/transaction_repository_implementation.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../../apis/firebase_cloud_storage_api/firebase_storage_api.dart';
import '../../../apis/receipt_api/receipt_builder_api.dart';
import '../../../models/order.dart' as t_order;

import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../../../models/user_profile.dart';
import '../../../repositories/transactions/transaction_repository_implementation.dart';
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

// TODO: REVISIT NAVIGATION HERE
class _InvoiceScreenState extends State<InvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  double amount;
  String message;
  String pdfLink;

  // TODO: Show Dialog on fail
  void sendReceipt(String message, List<String> recipients) async {
    var result = await sendSMS(message: message, recipients: recipients)
        .catchError(print);
  }

  @override
  void initState() {
    amount = widget.order.total;
    super.initState();
  }

  void createPdf() async {
    var pdf = await PdfGeneratorApi.generate(
        widget.order, widget.userProfileData, widget.allProducts);

    var link = await CloudApi().uploadPdf(pdf);

    setState(() {
      pdfLink = link;
    });
  }

  String getProductName(ProductVariant variant) {
    var product = widget.allProducts
        .where((element) => element.id == variant.productId)
        .toList();

    return product.first.name;
  }

  void createTransaction() async {
    var provider = Provider.of<TransactionRepository>(context, listen: false);

    var orders = widget.order.products.map((e) {
      var product = widget.allProducts
          .where((element) => element.id == e.productId)
          .toList()
          .first;

      var variant = product.variants
          .where((element) => element.variantId == e.variantId)
          .toList()
          .first;

      var order = t_order.Order(
          id: 0, product: product, quantity: e.quantity, variant: variant);

      return order;
    }).toList();

    var result = await provider.createTransaction(orders, link: pdfLink);

    if (result.isRight) {
      showTransactionResultSuccess();
    } else {
      showTransactionResultFail();
    }
  }

  Future<void> showTransactionResultSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Transaction"),
          content: SingleChildScrollView(
              child: Text("Transaction has been saved to database!")),
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

  Future<void> showTransactionResultFail() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Transaction"),
          content: SingleChildScrollView(
              child: Text("Please check your net. Transaction not saved!")),
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

  Future<void> showReceiptChoices() async {
    await createPdf();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Select a method"),
          content: SingleChildScrollView(
              child: Column(
            children: [
              ElevatedButton(
                child: Text("via SMS"),
                onPressed: () {
                  Navigator.of(context).pop();
                  showSmsDialog();
                },
              ),
            ],
          )),
          actions: [
            TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Future<void> showIncorrectAmount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment"),
          content: SingleChildScrollView(
              child: Text("Please enter the right amount.")),
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
          body.add(
              // ignore: lines_longer_than_80_chars
              "${getProductName(variant)} [${variant.variantName}]: ${variant.quantity} x  ${variant.price}\n");
        }
        message =
            // ignore: lines_longer_than_80_chars
            '${widget.userProfileData.name}\n${widget.userProfileData.address}\n${widget.userProfileData.email}\n\nOrders:\n${body.join()}\nTax (${widget.order.currentTax.percentage * 100}%): ${widget.order.totalAmountTax}\nTotal: ${widget.order.total + widget.order.totalAmountTax}\nAmount Paid: $amount\nChange: ${amount - widget.order.total - widget.order.totalAmountTax < 0 ? 0 : amount - widget.order.total - widget.order.totalAmountTax}\n\n${widget.userProfileData.receiptMessage}\n\nPDF link: $pdfLink';

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
                  onPressed: () async {
                    if (localKey.currentState.validate()) {
                      Navigator.of(context).pop();
                      //  TODO : Show Loading Indicator
                      await createTransaction();
                      await sendReceipt(message, ['$phoneNumber']);
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
    return Center(
      child: Container(
        margin: const EdgeInsets.all(1.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    onPressed: amount >=
                            widget.order.total + widget.order.totalAmountTax
                        ? showReceiptChoices
                        : showIncorrectAmount,
                    text: "Create Receipt",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
