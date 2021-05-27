import 'package:flutter/material.dart';

class InventoryListWidget extends StatefulWidget {
  final Function toggle;
  final Function getProducts;

  const InventoryListWidget({Key key, this.toggle, this.getProducts})
      : super(key: key);

  @override
  _InventoryListWidgetState createState() => _InventoryListWidgetState();
}

class _InventoryListWidgetState extends State<InventoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory List"),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("Get Products"),
          onPressed: () {
          widget.getProducts(context);
        }),
      ),
    );
  }
}
