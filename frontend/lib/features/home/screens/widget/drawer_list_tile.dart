import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DrawerListItem extends StatelessWidget {
  final String item;

  const DrawerListItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => print("list tile tapable"),
      title: Text(
        item,
        style: TextStyle(fontFamily: "Montserrat Bold", fontSize: 15),
      ),
    );
  }
}