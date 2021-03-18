import 'package:flutter/material.dart';
import 'package:frontend/views/auth/login_page.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'home/home_page.dart';

class Checker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null){
      return HomePage();
    }
    return (
      LoginPage()
    );
  }
}