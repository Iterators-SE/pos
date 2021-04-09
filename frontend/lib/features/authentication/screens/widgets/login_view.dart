import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80, left: 40, right: 40),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              child: Image(
                image: AssetImage('assets/images/Xpos.png'),
              ),
            ),
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Enter Email',
                  labelText: 'Email',
                ),
                validator: (value) => value.isEmpty
                    ? 'Email can\'t be empty'
                    : !EmailValidator.validate(value.toString())
                        ? "Email is invalid"
                        : null,
                onChanged: (value) => setState(() => email = value)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              key: Key('password'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Enter Password',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) =>
                    value.isEmpty ? "Password can\'t be empty" : null,
                onChanged: (value) => setState(() => password = value)),
            Spacer(),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                key: Key('login'),
                onPressed: () {
                  widget.formKey.currentState.validate()
                      ? widget.login()(context, email, password)
                      : null;
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                child: RichText(
                  text: TextSpan(
                    text: 'New here? ',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    children: [TextSpan(text: 'Sign up!')],
                  ),
                ),
                onPressed: widget.toggle,
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
