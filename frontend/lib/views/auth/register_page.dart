import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datasources/authentication/authentication_remote_datasource.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    String _emailAddress;
    String _password;
    String _name;
    final formKey = GlobalKey<FormState>();

    bool validateForm() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    void submitForm() async {
      if (validateForm()) {
        final dataSource = await Provider.of<AuthenticationRemoteDataSource>(
            context,
            listen: false);
        try {
          await dataSource.signup(
              name: _name, email: _emailAddress, password: _password);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } catch (e) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlertDialog(
                        content: Text(e.graphqlErrors[0].message),
                        actions: [
                          MaterialButton(
                            color: Colors.grey,
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          )
                        ],
                      )));
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 80, left: 40, right: 40),
          child: Form(
            key: formKey,
            child: SizedBox(
              width: 400,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Image(image: AssetImage('Xpos.png')),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create your store",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter Email',
                        labelText: 'Email'),
                    validator: (value) => value.isEmpty
                        ? 'Email can\'t be empty'
                        : !EmailValidator.validate(value.toString())
                            ? "Email Is Invalid"
                            : null,
                    onSaved: (value) {
                      _emailAddress = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter Password',
                        labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                        value.isEmpty ? "Password can\'t be empty" : null,
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter store name',
                        labelText: 'Store Name'),
                    validator: (value) =>
                        value.isEmpty ? "Store name can\'t be empty" : null,
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: submitForm,
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.grey)),
                    child: Text(
                      'Already have an account? Login Here!',
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
