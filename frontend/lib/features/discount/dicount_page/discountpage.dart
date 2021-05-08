import 'dart:html';
import 'package:flutter/material.dart';
import '../../../models/mock_discounts.dart';
import '../details/discount_details.dart';
import '../edit/discount_edit.dart';


class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<Discount> products = [
    Discount(name: "VIP discount"),
    Discount(name: "PWD discont")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discounts",
          style: TextStyle(fontFamily: "Montserrat Bold"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("ADD", style: TextStyle(fontFamily: "Montserrat Bold")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditDiscount()));
        },
      ),
      body: GridView.builder(
          itemCount: products.length,
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).orientation ==
                Orientation.landscape ? 3: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: (2 / 1),
                ),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                ),
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (contex) => DiscountDetails()
                      )
                    );
                  },
                  title: Text(
                    products[index].name,
                    style: TextStyle(fontFamily: "Montserrat Bold"),
                  ),
                ),
            );
          }),
    );
  }
}
