import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/datasources/authentication/authentication_remote_datasource.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState() ;
}

class _RegisterPageState extends State<RegisterPage>{
  @override
  Widget build(BuildContext context){
    final dataSource =
     Provider.of<AuthenticationRemoteDataSource>(context, listen: false);

     print(dataSource);
    return Scaffold(
      body: Text('THIS IS THE PAGEEE'),
    );
  }
}

