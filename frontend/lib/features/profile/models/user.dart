import 'package:flutter/cupertino.dart';

class User {
  final String imagePath;
  final String name;
  final String email;
  final String address;
  final String message;

  const User(
      {@required this.imagePath,
      @required this.name,
      @required this.email,
      @required this.address,
      @required this.message});
}
