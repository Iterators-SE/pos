import 'package:flutter/material.dart';

Widget form() {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            hintText: "Enter Discount Name")),
  );
}

Widget form2() {
  return Container(
    padding: EdgeInsets.only(right: 200),
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Container(
      child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              hintText: "Enter percent")),
    ),
  );
}
