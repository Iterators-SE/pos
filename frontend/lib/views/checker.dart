import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'auth/login_page.dart';
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