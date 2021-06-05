import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/profile/models/user.dart';
import 'package:frontend/features/profile/screens/page/profile_page.dart';
import 'package:frontend/features/profile/screens/widgets/profile_widget.dart';
import 'package:frontend/features/profile/screens/widgets/textfield_widget.dart';
import 'package:frontend/features/profile/utils/user_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }),
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.save_alt_rounded,
                // onPressed: () {},
              ), //onpressed here
            ),
            SizedBox(
              width: 10,
            )
          ]),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          ProfileWidget(
              imagePath: user.imagePath, isEdit: true, onClicked: () {}),
          SizedBox(height: 10),
          TextFieldWidget(
            label: 'FULL NAME',
            text: user.name,
            onChanged: (name) {},
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email) {},
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            label: 'Address',
            text: user.address,
            onChanged: (address) {},
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            label: 'Receipt Message',
            text: user.message,
            onChanged: (message) {},
          ),

          // FloatingActionButton(
          //   onPressed: onPressed)
        ],
      ),
    );
  }
}
