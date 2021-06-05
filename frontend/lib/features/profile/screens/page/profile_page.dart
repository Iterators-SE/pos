import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/profile_widget.dart';
import '../../utils/user_preferences.dart';
import 'edit_profile_page.dart';
//import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 30,
          ),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          buildName(user),
          SizedBox(
            height: 30,
          ),
          buildMessage(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          SizedBox(height: 5),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 5),
          Text(
            user.address,
            style: TextStyle(fontSize: 18),
          )
        ],
      );

  Widget buildMessage(User user) => Stack(children: [
        Container(
          height: 120,
          margin: EdgeInsets.all(10),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // child: Text(user.message),
          ),
        ),
        Positioned(top: 25, left: 30, child: Text(user.message))
      ]);
}
