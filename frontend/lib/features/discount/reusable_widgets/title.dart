import 'package:flutter/material.dart';

Widget title(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Montserrat Superbold", 
          fontSize: 30, 
          //fontWeight: FontWeight.w500
        ),
      ),
    ),
  );
}

Widget details(String details) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        details,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Montserrat Bold", 
          fontSize:28, 
          //fontWeight: FontWeight.w500
        ),
      ),
    ),
  );
}

