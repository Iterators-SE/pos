import 'package:flutter/material.dart';

import '../../core/ui/styled_text_button.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';
import '../../presenters/orders/order_screen_presenter.dart';
import '../../views/orders/order_screen_view.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_floating_action_button.dart';
import 'widget/product_card.dart';

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
    Product(name: "Poseidon", variants: [
      ProductVariant(
        id: 1,
        basePrice: 100,
        quantity: 300,
        variant: "Small",
        parent: "Poseidon",
      ),
      ProductVariant(
        id: 2,
        basePrice: 120,
        quantity: 40,
        variant: "Regular",
        parent: "Poseidon",
      ),
      ProductVariant(
        id: 3,
        basePrice: 180,
        quantity: 3,
        variant: "Large",
        parent: "Poseidon",
      ),
    ]),
    Product(name: "Olympus Cappucino", variants: [
      ProductVariant(
        id: 4,
        basePrice: 100,
        quantity: 300,
        variant: "Small",
        parent: "Olympus Cappucino",
      ),
      ProductVariant(
        id: 5,
        basePrice: 120,
        quantity: 40,
        variant: "Regular",
        parent: "Olympus Cappucino",
      ),
      ProductVariant(
        id: 6,
        basePrice: 180,
        quantity: 3,
        variant: "Large",
        parent: "Olympus Cappucino",
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
                        children: [
                          ...order.products
                              .map(
                                (i) => ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: double.infinity,
                                  ),
                                  child: ProductCard(product: i),
                                ),
                              )
                              .toList(),
                          Text(
                            order.total.toString(),
                            textAlign: TextAlign.end,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StyledTextButton(
                                text: "Cancel Order",
                                onPressed: order.products.isEmpty
                                    ? null
                                    : cancelOrder(),
                              ),
                              StyledTextButton(
                                text: "Process Order",
                                onPressed: order.products.isEmpty
                                    ? null
                                    : processOrder(),
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
