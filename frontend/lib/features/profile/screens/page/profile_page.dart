import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/app_state.dart';
import '../../../../models/user_profile.dart';
import '../../../../repositories/profile/profile_repository_implementation.dart';
import '../widgets/header_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile profileData;
  AppState state = AppState.done;

  @override
  void initState() {
    getUserDetails(context).then((value) {
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

  void updateProfileData(UserProfile data) {
    print("onChange!!!!");
    setState(() {
      print(data.name);
      profileData = data;
    });
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
    print("rebuilt");
    return Scaffold(
        appBar: AppBar(title: Text("Profile"), actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // print(profileData.name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(profile: profileData))).then((value) {
                updateProfileData(value[1]);

                if (value[0] == AppState.successful) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Successful!"),
                    ),
                  );
                } else if (value[0] == AppState.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("An error has occured. Unsuccessful!"),
                    ),
                  );
                }
              });
            },
          ),
          SizedBox(
            width: 10,
          )
        ]),
        body: state == AppState.done
            ? SingleChildScrollView(
                child: Column(
                children: [
                  Header(),
                  // Center(
                  //   child: Image(
                  //     image: AssetImage("assets/images/xpos_home_logo.png"),
                  //   ),
                  // ),
                  //   child: Stack(children: [
                  //     Container(
                  //       height: 150,
                  //       // color: xposGreen,
                  //       decoration: BoxDecoration(
                  //         color: xposGreen,
                  //         borderRadius: BorderRadius.only(
                  //             bottomLeft: Radius.circular(50),
                  //             bottomRight: Radius.circular(50)),
                  //             image:
                  //       ),
                  //     ),
                  //     Positioned(
                  //         bottom: 100,
                  //         child: Image.asset(
                  //           "assets/images/Xpos.png",
                  //           scale: 6,
                  //         )
                  //         // child: Image(
                  //         //   color: Colors.wh,
                  //         //   image: AssetImage("assets/images/Xpos.png"),
                  //         ),
                  //   ]),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    
                    margin: EdgeInsets.all(10),
                    height: 500,
                    child: Center(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(height: 10),
                          // TextFormField(
                          //   // key: Key("profileName"),
                          //   readOnly: true,
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     // fontWeight: FontWeight.bold
                          //   ),
                          //   initialValue: profileData.name,
                          //   decoration: InputDecoration(
                          //     labelText: 'Product Name',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          TextFormField(
                            key: Key(profileData.name),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold
                            ),
                            initialValue: profileData.name,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          // Text(profileData.name),
                          SizedBox(height: 30),
                          TextFormField(
                            key: Key(profileData.email),
                            // key: Key("profileEmail"),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold
                            ),
                            initialValue: profileData.email,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            key: Key(profileData.address),
                            // key: Key("profileAddress"),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold
                            ),
                            initialValue: profileData.address,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            key: Key(profileData.receiptMessage),
                            // key: Key("profileReceiptMessage"),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold
                            ),
                            initialValue: profileData.receiptMessage,
                            decoration: InputDecoration(
                              labelText: 'Receipt Message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
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
