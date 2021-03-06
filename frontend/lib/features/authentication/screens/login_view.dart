import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'widgets/action_button.dart';
import 'widgets/logo.dart';
import 'widgets/network_button.dart';

class LoginWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function toggle;
  final Function login;

  const LoginWidget({Key key, this.formKey, this.toggle, this.login})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool hide = true;
  String email, password;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height,
      padding: EdgeInsets.only(top: 80, left: 40, right: 40),
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
              key: Key('email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter Email',
                labelText: 'Email',
              ),
              validator: (value) => value.isEmpty
                  ? 'Email can\'t be empty'
                  : !EmailValidator.validate(value.toString())
                      ? "Email is invalid"
                      : null,
              onChanged: (value) => setState(() => email = value),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: Key('password'),
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
              validator: (value) =>
                  value.isEmpty ? "Password can\'t be empty" : null,
              onChanged: (value) => setState(() => password = value),
            ),
            Spacer(),
            NetworkButton(
              onPressed: () {
                widget.formKey.currentState.validate()
                    ? widget.login()(context, email, password)
                    : null;
              },
              text: 'Login',
              buttonKey: 'login',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                toggle: widget.toggle,
                text: 'New here? ',
                textSpanText: 'Sign up!',
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
