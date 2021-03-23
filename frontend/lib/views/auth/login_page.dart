import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datasources/authentication/authentication_remote_datasource.dart';
import '../../models/user.dart';
import '../checker.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        final user =
            await dataSource.login(email: _emailAddress, password: _password);
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context) =>
            Provider<User>(create: (context) => user, child: Checker(),)
            ));
      } catch (e) {
        print("emailerssss");
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

  String _emailAddress;
  String _password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  Image(image: AssetImage('assets/Xpos.png')),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
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
                        "Continue to your Store",
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
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  MaterialButton(
                    textColor: Colors.grey,
                    child: Text('New Here? Sign Up Now!'),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
