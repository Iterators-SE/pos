import 'package:flutter/material.dart';
//import '../presenter/menu_presenter.dart';
import '../model/menu_data.dart';

Widget menuWidget(Menu element) {
  return InkWell(
      key: Key(element.id),
      onTap: () {
        print(element.option);
      },
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
        height: 180,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown[400]),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(element.url),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover)),
        child: Center(
            child: Text(
          element.option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat Bold",
            fontSize: 20,
          ),
        )),
      ));
}