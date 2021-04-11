import 'package:flutter/material.dart';
import 'package:frontend/views/product_details/product_edit.dart';
import 'mock_products.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cappuccino.jpg")
                )),
            child: Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
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
            width: 100,
            margin: EdgeInsets.only(bottom: 30, top: 10),
              child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontFamily: "Montserrat Bold", fontSize: 14),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.all(10),
                          child: Text("REGULAR",
                              style: TextStyle(
                                  fontFamily: "Montserrat Bold", fontSize: 18)),
                        )
                      ]),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(children: [
                        Text(
                          "Price:",
                          style: TextStyle(
                              fontFamily: "Montserrat Bold", fontSize: 14),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:5),
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("100",
                                  style: TextStyle(
                                      fontFamily: "Montserrat Bold",
                                      fontSize: 18)),
                            ))
                      ]),
                    )),
              ],
            ),
          ),
          Container(
            //width: 50,
            margin: EdgeInsets.only(left:130, right: 130, bottom: 20),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child: FlatButton(
              child: Text(
                "EDIT",
                style: TextStyle(
                  fontFamily: "Montserrat Bold"  
                  ),
                ),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => EditProductDetail()
                  )
                );
              },
          ),
            )
        ],
      ),
    );
  }
}
