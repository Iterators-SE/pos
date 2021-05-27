import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/styled_text_button.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../models/order.dart';
import '../presenters/order_screen_presenter.dart';
import '../views/order_screen_view.dart';
import 'invoice_screen.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/custom_floating_action_button.dart';
import 'widget/order_button.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> implements OrderScreenView {
  OrderScreenPresenter _presenter;

  Order order;
  AppState state = AppState.loading;
  Failure failure;
  Widget body;
  bool hasProducts = false;

  List<Product> allProducts = [];

  @override
  Function cancelOrder() {
    return () => setState(() {
          hasProducts = false;
          order = Order();
        });
  }

  @override
  Function processOrder() {
    return () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceScreen(
              order: order,
              allProducts: allProducts,
            ),
          ),
        );
  }

  @override
  void addProduct(ProductVariant product) {
    setState(() {
      hasProducts = true;
      order.editProduct(product);
    });
  }

  @override
  Function addDiscount() {
    return () => null;
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    return await Provider.of<InventoryRepository>(context, listen: false)
        .getProducts();
  }

  List list = [];

  @override
  void initState() {
    _presenter = OrderScreenPresenter();
    _presenter.attachView(this);

    state = AppState.loading;
    order = Order();

    getProducts().then((value) {
      var data = value.fold((failure) => failure, (result) => result);
      if (value.isRight) {
        setState(() {
          allProducts = data;
          state = AppState.done;
        });
      } else {
        setState(() {
          state = AppState.error;
          failure = data;
        });
      }
    });

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
                              OrderButton(
                                text: "Cancel Order",
                                onPressed:
                                    order.products.isEmpty ? null : cancelOrder,
                              ),
                              OrderButton(
                                text: "Process Order",
                                onPressed: processOrder,
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
