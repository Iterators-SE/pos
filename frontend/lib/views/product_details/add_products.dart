
import 'package:flutter/material.dart';

import 'mock_products.dart';
import 'product_details.dart';
import 'product_edit.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Products> products = [
    Products(name: "Cappuccino", price: "60"),
    Products(name: "Cappuccino", price: "60")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Products"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProductDetail()));
          },
        ),
        body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                  ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (contex) => ProductDetail()
                      )
                    );
                  },
                  leading: Icon(Icons.image_outlined),
                  title: Text(products[index].name),
                ),
              );
            }));
  }
}
