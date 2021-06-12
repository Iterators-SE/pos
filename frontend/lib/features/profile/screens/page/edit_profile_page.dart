import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/state/app_state.dart';
import '../../../../models/user_profile.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;

  EditProfilePage({Key key, this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserProfile profileData;
  AppState state = AppState.done;

  @override
  void initState() {
    profileData = widget.profile;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 10),
            TextFormField(
              readOnly: false,
              decoration: InputDecoration(
                labelText: ' Store name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialValue: "${widget.profile.name}",
              onChanged: (value) {
                print(value);
                profileData.name = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: ' Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialValue: "${widget.profile.email}",
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: false,
              decoration: InputDecoration(
                labelText: ' Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialValue: "${widget.profile.address}",
              onChanged: (value) {
                print(value);
                profileData.address = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: false,
              decoration: InputDecoration(
                labelText: ' Receipt Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialValue: "${widget.profile.receiptMessage}",
              onChanged: (value) {
                profileData.receiptMessage = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // updateInfo();
                },
                child: Text("Save Changes"))
          ],
        ),
      ),
    );
  }
}
