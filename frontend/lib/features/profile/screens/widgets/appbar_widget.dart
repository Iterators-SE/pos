import 'package:flutter/material.dart';

AppBar buildAppbar(BuildContext context) {
  return AppBar(
    leading: BackButton(color: Colors.white, onPressed: () {}),
    title: Text("Profile"),
    actions: [
      IconButton(
        icon: Icon(Icons.edit),
        // onPressed: on,
      ), //onpressed here
    ],
  );
}
