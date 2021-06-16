import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/app_state.dart';
import '../../../../models/user_profile.dart';
import '../../../../repositories/profile/profile_repository_implementation.dart';
import '../widgets/header_widget.dart';

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

  Future<void> showLoading() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Loading"),
          content: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text("Please wait"),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  void onSave() async {
    showLoading();
    var provider = Provider.of<ProfileRepository>(context, listen: false);
    var newProfileData = await provider.updateProfileInfo(profileData);
    Navigator.of(context).pop();

    var foldedProfileData =
        newProfileData.fold((fail) => UserProfile(), (data) => data);

    if (newProfileData.isRight) {
      Navigator.pop(context, [AppState.successful, foldedProfileData]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: state == AppState.done
            ? Form(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Header(),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: ' Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialValue: "${widget.profile.email}",
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () async {
                            var provider = Provider.of<ProfileRepository>(
                                context,
                                listen: false);
                            await provider.updateProfileInfo(profileData);
                          },
                          child: Text("Save Changes")),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
