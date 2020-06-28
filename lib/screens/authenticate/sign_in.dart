import 'package:beaconapplication/services/auth.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:beaconapplication/shared/loading.dart';
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

final _formkey = GlobalKey<FormState>();
final AuthService _auth = AuthService();
bool loading = false;

String email = "";
String password="";
String error = "";

class _SignInState extends State<SignIn> {
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Register"),
              onPressed: (){
                widget.toggleView();
              },
            )
          ],
        ),
        body: Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) => val.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) => val.length < 6
                            ? "Enter a password 6+ chars long"
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() => loading = true);
                            print("Validate");
                            dynamic result =
                            await _auth.SignInWithEmailAndPassword(
                                email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                "Could  not sign in. Wrong input ";
                                loading = false;
                              });
                            }
                          }
                        }
                      ),
                      SizedBox(
                        height: 10.00,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}
