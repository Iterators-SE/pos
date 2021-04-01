import 'package:flutter/material.dart';

import '../core/ui/styled_text_button.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../presenters/orders/order_screen_presenter.dart';
import '../views/orders/order_screen_view.dart';
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
  onError() {
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
  void addProduct(Product product) {
    setState(() {
      hasProducts = true;
      order.addProduct(product);
      _items++;
    });
  }

  // Dummy data
  List<Product> productsList = [
    Product(
      name: "Poseidon",
      basePrice: 100,
      quantity: 2,
      id: 1,
      variant: "Small",
    ),
    Product(
      name: "Hera",
      basePrice: 120,
      quantity: 7,
      id: 2,
      variant: "Medium",
    ),
    Product(
      name: "Zeus",
      basePrice: 150,
      quantity: 1,
      id: 3,
      variant: "Large",
    )
  ];

  int _items = 0;
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
        body: body = hasProducts
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Orders",
                      style: TextStyle(fontSize: 48, fontFamily: 'Montserrat'),
                    ),
                    ...order.products
                        .map((i) => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: double.infinity,
                              ),
                              child: ProductCard(product: i),
                            ))
                        .toList(),
                    Text(order.total.toString(), textAlign: TextAlign.end),
                    Row(
                      children: [
                        StyledTextButton(
                          text: "Cancel Order",
                          onPressed: _items == 0 ? null : cancelOrder(),
                        ),
                        StyledTextButton(
                          text: "Process Order",
                          onPressed: _items == 0 ? null : processOrder(),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Text("Looks a little empty..."),
                    StyledTextButton(
                      text: "Add an Order",
                      onPressed: () => addProduct(productsList[_items]),
                    )
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _items < productsList.length
              ? addProduct(productsList[_items])
              : null,
        ),
      ),
    );
  }
}
