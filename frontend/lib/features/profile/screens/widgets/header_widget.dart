import 'package:flutter/cupertino.dart';
import '../../../../core/themes/config.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 120,
        decoration: BoxDecoration(
            color: xposGreen,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/Xpos.png", scale: 6),
          ),
        ),
      ),
    ]);
  }
}
