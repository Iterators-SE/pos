import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/themes/config.dart';
import '../../../../core/ui/styled_text_button.dart';

class OrderButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const OrderButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(right: 5),
      child: StyledTextButton(
        text: text,
        onPressed: onPressed,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: xposGreen[50]),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
