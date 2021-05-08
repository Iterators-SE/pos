import 'package:flutter/material.dart';

import '../../../models/mock_discounts.dart';
import '../details/discount_details.dart';
import '../edit/discount_edit.dart';
import '../reusable_widgets/title.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<Discount> products = [
    Discount(name: "VIP discount"),
    Discount(name: "PWD discount"),
    Discount(name: "PWD discount"),
    Discount(name: "PWD discount"),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditDiscount()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30.0),
               ),),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contex) => DiscountDetails()
                      )
                    );
                  },
                  child: discountTitles(products[index].name),
                  ),
                );
            }),
      ),
    );
  }
}
