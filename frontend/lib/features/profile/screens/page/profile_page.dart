import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/app_state.dart';
import '../../../../models/user_profile.dart';
import '../../../../repositories/profile/profile_repository_implementation.dart';
import '../widgets/textfield_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile profileData;
  AppState state = AppState.loading;

  @override
  void initState() {
    getUserDetails(context).then((value){
      
    if (value.email.isNotEmpty) {
      setState(() {
        profileData = value;
        state = AppState.done;
      });
     
    } else {
      setState(() {
        state = AppState.error;
      });
    }
    });
    super.initState();
  }

  Future<UserProfile> getUserDetails(BuildContext context) async {
    setState(() {
      state = AppState.loading;
    });

    var provider = Provider.of<ProfileRepository>(context, listen: false);
    var profileResult = await provider.getProfileInfo();
    var profile = profileResult.fold((fail) => UserProfile(), (data) => data);
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile"), actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print(profileData.name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(profile: profileData)));
            },
          ),
          SizedBox(
            width: 10,
          )
        ]),
        body: state == AppState.done
            ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 28),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 10),
                  TextFieldWidget(
                    label: 'FULL NAME',
                    text: profileData.name,
                    onChanged: (name) {},
                  ),
                  SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Email',
                    text: profileData.email,
                    onChanged: (email) {},
                  ),
                  SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Address',
                    text: profileData.address,
                    onChanged: (address) {},
                  ),
                  SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Receipt Message',
                    text: profileData.receiptMessage,
                    onChanged: (message) {},
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));

    // Widget buildName(UserProfile user) => Column(
    //       children: [
    //         Text(
    //           user.name,
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    //         ),
    //         SizedBox(height: 5),
    //         Text(
    //           user.email,
    //           style: TextStyle(color: Colors.grey),
    //         ),
    //         SizedBox(height: 5),
    //         Text(
    //           user.address,
    //           style: TextStyle(fontSize: 18),
    //         )
    //       ],
    //     );

    // Widget buildMessage(User user) => Stack(children: [
    //       Container(
    //         height: 120,
    //         margin: EdgeInsets.all(10),
    //         child: InputDecorator(
    //           decoration: InputDecoration(
    //             labelText: 'Message',
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //           ),
    //           // child: Text(user.message),
    //         ),
    //       ),
    //       Positioned(top: 25, left: 30, child: Text(user.message))
    //     ]);
  }
}
