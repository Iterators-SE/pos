import 'package:flutter/material.dart';

class FABWrapper extends StatelessWidget {
  final Function onPressed;
  final String tooltip;
  final IconData iconData;

  const FABWrapper({Key key, this.onPressed, this.tooltip, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: tooltip,
        onPressed: onPressed,
        tooltip: tooltip,
        child: Icon(iconData),
      ),
    );
  }
}
