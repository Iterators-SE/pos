import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ToggleViewWidget extends StatefulWidget {
  final List<bool> isSelected;
  final List<Icon> icons;
  final Function onPressed;

  ToggleViewWidget({
    Key key,
    @required this.isSelected,
    @required this.icons,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _ToggleViewWidgetState createState() => _ToggleViewWidgetState();
}

/// Reference: https://medium.com/flutter-community/flutter-widget-in-focus-togglebuttons-know-it-all-b0f0c23f4518
class _ToggleViewWidgetState extends State<ToggleViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      color: Colors.grey,
      selectedColor: Colors.blueAccent,
      children: widget.icons,
      isSelected: widget.isSelected,
      highlightColor: Colors.white10,
      splashColor: Colors.white10,
      onPressed: widget.onPressed,
    );
  }
}
