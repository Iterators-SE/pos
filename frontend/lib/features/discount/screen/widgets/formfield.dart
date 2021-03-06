import 'package:flutter/material.dart';

Widget form() {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: "Discount Name")),
  );
}

Widget form2(int _percentage) {
  return Container(
    padding: EdgeInsets.only(right: 200),
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Container(
      child: TextFormField(
          validator: (value) =>
              value == null ? 'Please enter percentage' : null,
          onChanged: (value) => _percentage = int.parse(value),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              labelText: "Percentage")),
    ),
  );
}
