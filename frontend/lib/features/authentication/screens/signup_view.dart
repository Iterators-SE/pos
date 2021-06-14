import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'widgets/action_button.dart';
import 'widgets/logo.dart';
import 'widgets/network_button.dart';

class SignupWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function toggle;
  final Function signup;

  const SignupWidget({Key key, this.formKey, this.toggle, this.signup})
      : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  bool hide = true;
  String name, email, password;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 80, left: 40, right: 40),
      height: height,
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            XposLogo(),
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
                  hintText: 'Enter store name',
                  labelText: 'Store Name'),
              validator: (value) =>
                  value.isEmpty ? "Store name can\'t be empty" : null,
              onChanged: (value) => setState(() => name = value),
            ),
            SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              onChanged: (value) => setState(() => email = value),
            ),
            SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => hide = !hide),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter Password',
                labelText: 'Password',
              ),
              obscureText: hide,
              validator: (value) => value.isEmpty
                  ? "Password can\'t be empty"
                  : value.trim().length < 8
                      ? "Password must be at least 8 characters long"
                      : null,
              onChanged: (value) => setState(() => password = value),
            ),
            Spacer(),
            NetworkButton(
              onPressed: () {
                widget.formKey.currentState.validate()
                    ? widget.signup()(context, email, name, password)
                    : null;
              },
              text: 'Signup',
              buttonKey: 'signup',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                toggle: widget.toggle,
                text: 'Already have an account? ',
                textSpanText: 'Login!',
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
