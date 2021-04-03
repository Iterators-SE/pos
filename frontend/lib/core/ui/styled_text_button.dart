import 'package:flutter/material.dart';

class StyledTextButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const StyledTextButton({Key key, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "${text}_button",
      button: true,
      onTap: onPressed,
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
