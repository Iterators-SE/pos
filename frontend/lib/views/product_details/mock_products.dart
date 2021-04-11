import 'package:flutter/material.dart';

class Products {
  String name;
  String price;
  final Function onTap;

  Products({this.name, this.price, this.onTap});
}

