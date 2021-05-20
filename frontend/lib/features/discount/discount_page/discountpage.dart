import 'package:flutter/material.dart';
import '../../../models/mock_discounts.dart';
import '../details/discount_details.dart';
import '../edit/discount_edit.dart';
// import '../reusable_widgets/title.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<Discount> products = [
    Discount(name: "VIP discount", percent: 50),
    Discount(name: "PWD discount", percent: 25),
    Discount(name: "PWD discount", percent: 25),
    Discount(name: "PWD discount", percent: 25),
  ];
  List<int> colorCodes = [700, 600, 400, 300, 50];

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
          padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 35, 15, 25),
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              products[index].name,
                              style: TextStyle(
                                  fontFamily: "Montserrat Bold", fontSize: 25),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${products[index].percent.toString()} %",
                              style: TextStyle(
                                  fontFamily: "Montserrat Bold", fontSize: 25),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[colorCodes[index]]),
                      // decoration:
                      // BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => DiscountDetails()));
                    });
              })),
    );
  }
}
