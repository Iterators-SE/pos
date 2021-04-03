import 'package:flutter/material.dart';
//import '../model/drawerList_data.dart';

Widget drawerList(String list) {
  return ListTile(
      onTap: () {
        print("list tile tapable");
      },
      title: Text(list,
          style: TextStyle(fontFamily: "Montserrat Bold", fontSize: 15)));
}