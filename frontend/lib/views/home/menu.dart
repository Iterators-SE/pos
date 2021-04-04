import 'package:flutter/material.dart';

class Menu {
  String id;
  String option;
  String url;
  final Function onTap;

  Menu({this.id, this.option, this.url, this.onTap});
}

Widget menuWidget(Menu element) {
  return InkWell(
    key: Key(element.id),
    onTap: element.onTap,
    child: Container(
      margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown[400]),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(element.url),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.dstATop,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          element.option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat Bold",
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

Widget drawerList(String list) {
  return ListTile(
    onTap: () => print("list tile tapable"),
    title: Text(
      list,
      style: TextStyle(fontFamily: "Montserrat Bold", fontSize: 15),
    ),
  );
}
