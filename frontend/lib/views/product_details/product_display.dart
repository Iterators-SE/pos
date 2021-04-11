import "package:flutter/material.dart";
import 'package:frontend/views/product_details/mock_products.dart';

Widget productListTile(Products product) {


  return Container(
    color: Colors.red,
    child: ListTile(
      onTap: () {
        product.onTap;
      },
      leading: Icon(Icons.image),
      title: Text(product.name),
    ),
  );
}
