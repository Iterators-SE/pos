import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../core/ui/styled_text_button.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../../../repositories/discount/discount_repository_implementation.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../models/order.dart';
import '../presenters/order_screen_presenter.dart';
import '../views/order_screen_view.dart';
import 'invoice_screen.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/custom_floating_action_button.dart';
import 'widget/discount_dialog.dart';
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
  List<Discount> allDiscounts = [];

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
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: InvoiceScreen(
                order: order,
                allProducts: allProducts,
              ),
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
  void addDiscount(List<Discount> discounts) {
    setState(() => order.addDiscount(discounts));
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    // return await Provider.of<InventoryRepository>(context, listen: false)
    //     .getProducts();
    return Right([
      Product(id: 2, name: "Poseidon", variants: [
        ProductVariant(
          variantId: 1,
          price: 100,
          quantity: 300,
          variantName: "Small",
          productId: 2,
        ),
        ProductVariant(
          variantId: 2,
          price: 120,
          quantity: 40,
          variantName: "Regular",
          productId: 2,
        ),
        ProductVariant(
          variantId: 3,
          price: 180,
          quantity: 3,
          variantName: "Large",
          productId: 2,
        ),
      ]),
      Product(id: 1, name: "Olympus Cappucino", variants: [
        ProductVariant(
          variantId: 4,
          price: 100,
          quantity: 300,
          variantName: "Small",
          productId: 1,
        ),
        ProductVariant(
          variantId: 5,
          price: 120,
          quantity: 40,
          variantName: "Regular",
          productId: 1,
        ),
        ProductVariant(
          variantId: 6,
          price: 180,
          quantity: 3,
          variantName: "Large",
          productId: 1,
        ),
      ]),
    ]);
  }

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    // return await Provider.of<DiscountRepository>(context, listen: false)
    //     .getDiscounts();

    return Right([
      Discount(
        id: 1,
        percentage: 20,
        products: [1, 2],
        description: "Senior Citizen",
      ),
      Discount(
        id: 2,
        percentage: 15,
        products: [1, 2],
        description: "PWD",
      )
    ]);
  }

  @override
  void initState() {
    _presenter = OrderScreenPresenter();
    _presenter.attachView(this);

    state = AppState.loading;
    order = Order();

    getDiscounts().then((value) {
      var data = value.fold((failure) => failure, (result) => result);

      if (value.isRight) {
        setState(() => allDiscounts = data);

        getProducts().then((product) {
          var data = product.fold((failure) => failure, (result) => result);
          if (product.isRight) {
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
                              DataColumn(
                                  label: Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataColumn(
                                label: Text(
                                  'Breakdown',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                      order.discountTotal.toString(),
                                    ),
                                  )
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text("Total")),
                                  DataCell(
                                    Text(
                                      '${order.total - order.discountTotal}',
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
                                onPressed: !hasProducts ? null : cancelOrder(),
                              ),
                              OrderButton(
                                text: "Process Order",
                                onPressed: hasProducts ? processOrder() : null,
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
          onAddDiscount: () async => await showDialog(
            context: context,
            builder: (context) => DiscountDialog(
              discounts: allDiscounts,
              selectedDiscounts: order.discounts.toList(),
              onPressed: () => addDiscount,
            ),
          ),
        ),
      ),
    );
  }
}
