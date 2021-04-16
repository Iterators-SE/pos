import 'package:flutter/material.dart';

class EditProductDetail extends StatefulWidget {
  @override
  _EditProductDetailState createState() => _EditProductDetailState();
}

class _EditProductDetailState extends State<EditProductDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: TextButton(
              onPressed: () {}, 
              child: Icon(
                Icons.add_a_photo,
                size: 80,
                )
              )
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
                  margin: EdgeInsets.only(left: 20, right: 20, top:10),
                  child:TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    hintText: "Enter product name"
                  )
                ) ,
                  )
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
                    //height: 100,
                    width: 380,
                    margin: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:TextFormField(
                        //maxLines: ,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    hintText: "Enter product description"
                  )
                ) ,
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
          // height: 100,
           margin: EdgeInsets.only(bottom: 30, top: 10),
           //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
           child: Row(
             children: [
               Expanded(
                 flex: 2,
                 child: Container(
                child: Column(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 14
                      ),
                      ),
                    Container(
                        padding: EdgeInsets.all(5),
                      child: TextFormField(
                        //maxLines: ,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                  )
                ) ,
                    )
                  ]
                ),
              )
              ),
              Expanded(
                flex: 2,
               child: Container(
                child: Column(
                  children: [
                    Text(
                      "Price:",
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 14
                      ),
                      ),
                    Container(                     
                        padding: EdgeInsets.all(5),
                        child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                        //maxLines: ,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                  )
                ) ,
                      )
                    )
                  ]
                ),
              )
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(right:10),
                  child: TextButton(
                    onPressed: (){}, 
                    child: Icon(
                    Icons.add_box_rounded,
                    size: 30,
                  ),
                    )
                )
                )
             ],
           ),
          )
        ],
      ),
      )
    ;
  }
}
