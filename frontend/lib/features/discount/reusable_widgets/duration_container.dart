import 'package:flutter/material.dart';
import '../../../core/themes/config.dart';

Widget durationContainer(String input) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
    margin: EdgeInsets.only(right: 5),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        input,
        style: TextStyle(fontSize: 20),
      ),
    ),
    decoration: BoxDecoration(
        border: Border.all(color: xposGreen[50]),
        borderRadius: BorderRadius.all(Radius.circular(30))),
  );
}
