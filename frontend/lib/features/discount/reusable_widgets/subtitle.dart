import 'package:flutter/material.dart';

Widget subtitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Montserrat", 
          fontSize: 20, 
          //fontWeight: FontWeight.w500
        ),
      ),
    ),
  );
}
