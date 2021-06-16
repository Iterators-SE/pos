
import 'package:flutter/material.dart';
import '../core/themes/config.dart';



Widget appBar(String pageName){
  return AppBar(
    bottom: PreferredSize(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black),
          color: Colors.white,
          boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(5.0, 8.0),
                  blurRadius: 4.0,
                  spreadRadius: 1.50)
                ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 10),
          child: Text(
            pageName,
            style: TextStyle(
              fontFamily: "Montserrat Superbold",
              fontSize: 30
            ),
            ),
        ),
        
        ),
      preferredSize: Size.fromHeight(50),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    leading: BackButton(
      color: xposGreen[300],
    ),
  );
}