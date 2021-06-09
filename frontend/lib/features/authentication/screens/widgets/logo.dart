import 'package:flutter/material.dart';

class XposLogo extends StatelessWidget {
  const XposLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 150),
      child: Image(
        image: AssetImage('assets/images/Xpos.png'),
      ),
    );
  }
}
