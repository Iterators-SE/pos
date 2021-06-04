import 'package:flutter/material.dart';

class InventoryFAB extends StatelessWidget {
  final Function onPressed;
  final String label;

  const InventoryFAB({Key key, this.onPressed, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(label),
      onPressed:  onPressed
    );
  }
}
