import 'package:flutter/material.dart';
import '../../../core/themes/config.dart';

import '../../../core/ui/styled_text_button.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../models/order.dart';
import '../presenters/order_screen_presenter.dart';
import '../views/order_screen_view.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/custom_floating_action_button.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> implements OrderScreenView {
  OrderScreenPresenter _presenter;

  Order order;
  Widget body;
  bool hasProducts = false;

  @override
  Function cancelOrder() {
    // TODO: implement cancelOrder
    // throw UnimplementedError();
    return () => print("CANCELLING ORDER");
  }

  @override
  void onError() {
    // TODO: implement onError
    // throw UnimplementedError();
  }

  @override
  Function processOrder() {
    // TODO: implement processOrder
    // Preview invoice and print
    // throw UnimplementedError();
    return () => print("HI ORDER");
  }

  @override
  void addProduct(ProductVariant product) {
    setState(() {
      hasProducts = true;
      order.editProduct(product);
    });
  }

  // Dummy data
  List<Product> allProducts = [
    Product(id: 2, name: "Poseidon", variants: [
      ProductVariant(
        variantid: 1,
        price: 100,
        quantity: 300,
        variantName: "Small",
        productID: 2,
      ),
      ProductVariant(
        variantid: 2,
        price: 120,
        quantity: 40,
        variantName: "Regular",
        productID: 2,
      ),
      ProductVariant(
        variantid: 3,
        price: 180,
        quantity: 3,
        variantName: "Large",
        productID: 2,
      ),
    ]),
    Product(id: 1, name: "Olympus Cappucino", variants: [
      ProductVariant(
        variantid: 4,
        price: 100,
        quantity: 300,
        variantName: "Small",
        productID: 1,
      ),
      ProductVariant(
        variantid: 5,
        price: 120,
        quantity: 40,
        variantName: "Regular",
        productID: 1,
      ),
      ProductVariant(
        variantid: 6,
        price: 180,
        quantity: 3,
        variantName: "Large",
        productID: 1,
      ),
    ]),
  ];

  List list = [];

  @override
  void initState() {
    _presenter = OrderScreenPresenter();
    _presenter.attachView(this);

    order = Order();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Orders"),
            ),
            SliverFillRemaining(
              child: body = hasProducts
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDataTable(
                            order: order,
                            onPressed: () => (productVariant) async =>
                                await showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                    chosenProduct: allProducts.firstWhere(
                                      (e) => e.id == productVariant.productID,
                                    ),
                                    quantity: productVariant.quantity,
                                    chosenVariant: productVariant.variantName,
                                    allProducts: allProducts,
                                    onPressed: () => addProduct,
                                  ),
                                ),
                          ),
                          CustomDataTable(
                            columns: [
                              DataColumn(label: Text('Description')),
                              DataColumn(
                                label: Text('Breakdown'),
                                numeric: true,
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text("Base Price")),
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 5, right: 10, bottom: 5),
                                margin: EdgeInsets.only(right: 5),
                                child: StyledTextButton(
                                  text: "Cancel Order",
                                  onPressed: order.products.isEmpty
                                      ? null
                                      : cancelOrder(),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: xposGreen[50]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 5, right: 10, bottom: 5),
                                margin: EdgeInsets.only(right: 5),
                                child: StyledTextButton(
                                  text: "Process Order",
                                  onPressed: () => {}
                                    
                                    
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: xposGreen[50]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Looks a little empty...")),
                        StyledTextButton(
                          text: "Add an Order",
                          onPressed: () async => await showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              allProducts: allProducts,
                              onPressed: () => addProduct,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
        floatingActionButton: CustomFAB(
          onAddProduct: () async => await showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              allProducts: allProducts,
              onPressed: () => addProduct,
            ),
          ),
          onAddDiscount: null,
        ),
      ),
    );
  }
}
