import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomDiscountFAB extends StatelessWidget {
  final Function onPressed;
  final String label;
  final IconData icon;

  const CustomDiscountFAB({
    Key key,
    @required this.onPressed,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: label,
      icon: Icon(icon),
      label: Text(label, style: TextStyle(fontFamily: "Montserrat Bold")),
      onPressed: onPressed,
    );
  }
}
