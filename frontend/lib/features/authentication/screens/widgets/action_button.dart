import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ActionButton extends StatelessWidget {
  final Function toggle;
  final String text;
  final String textSpanText;

  const ActionButton({
    Key key,
    @required this.toggle,
    @required this.text,
    @required this.textSpanText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
          children: [TextSpan(text: textSpanText)],
        ),
      ),
      onPressed: toggle,
    );
    // MaterialButton(
    //   child: RichText(
    //     text: TextSpan(
    //       text: 'Already have an account? ',
    //       style: TextStyle(color: Colors.grey[500], fontSize: 12),
    //       children: [TextSpan(text: 'Login!')],
    //     ),
    //   ),
    //   onPressed: widget.toggle,
    // );
  }
}
