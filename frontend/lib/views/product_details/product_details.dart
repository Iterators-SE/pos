import 'package:flutter/material.dart';
import 'mock_variants.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Variant> sample = [
    Variant(type: "R", price: "50"),
    Variant(type: "M", price: "70"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/cappuccino.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Product Name:",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: "Montserrat Bold", fontSize: 20),
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: 380,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Cappuccino",
                        style: TextStyle(
                            fontSize: 23, fontFamily: "Montserrat Bold"),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Product Description:",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: "Montserrat Bold", fontSize: 20),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    height: 100,
                    width: 380,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Freshly brewed goodness!",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Montserrat Bold"),
                      ),
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "Variants:",
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: "Montserrat Bold", fontSize: 20),
              ),
            ),
          ),
         Container(
            height: 200,
            child: Row(children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  
                ),
              ),
              Flexible(
                flex: 1,
                  child: Container(
                  child: Icon(Icons.close),
              ))
            ]),
          )
        ],
      ),
      )
    ;
  }
}
