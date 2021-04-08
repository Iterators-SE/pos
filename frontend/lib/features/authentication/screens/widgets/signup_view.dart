import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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
  @override
  Widget build(BuildContext context) {
    String name, email, password;

    return Container(
      padding: EdgeInsets.only(top: 80, left: 40, right: 40),
      child: Form(
        key: widget.formKey,
        child: SizedBox(
          width: 400,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/Xpos.png')),
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
                onChanged: (value) => setState(() => email = value),
              ),
              Spacer(),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Password',
                    labelText: 'Password'),
                obscureText: true,
                validator: (value) => value.isEmpty
                    ? "Password can\'t be empty"
                    : value.trim().length <= 8
                        ? "Password must be at least 8 characters long"
                        : null,
                onChanged: (value) => setState(() => password = value),
              ),
              Spacer(),
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
              Spacer(),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  onPressed: () {
                  widget.formKey.currentState.validate()
                      ? widget.signup(
                          context,
                          email,
                          name,
                          password,
                        )
                      : null;
                },
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
                onPressed: widget.toggle,
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
