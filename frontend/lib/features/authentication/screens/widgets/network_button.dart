import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/themes/config.dart';

class NetworkButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final String buttonKey;

  const NetworkButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        color: xposGreen[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        key: Key(buttonKey),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
