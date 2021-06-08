import 'package:flutter/material.dart';
import '../../../home/screens/home_screen.dart';
import '../page/edit_profile_page.dart';

AppBar buildAppbar(BuildContext context) {
  return AppBar(
    leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }),
    title: Text("Profile"),
    actions: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
        },
      ), //onpressed here
    ],
  );
}
