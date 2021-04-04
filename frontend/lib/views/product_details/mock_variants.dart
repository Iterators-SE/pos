import 'package:flutter/material.dart';

class Variant {
  String type;
  String price;

  Variant({this.type, this.price});
}

Widget variants(Variant element) {
  return Container(
    height: 200,
    child: Row(children: <Widget>[
      Flexible(
        child: Container(
          height: 30,
        ),
      ),
      Flexible(
          child: Container(
        child: Icon(Icons.close),
      ))
    ]),
  );
}
