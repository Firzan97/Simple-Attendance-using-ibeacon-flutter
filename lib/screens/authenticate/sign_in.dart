import 'package:beaconapplication/component/already_have_an_account_acheck.dart';
import 'package:beaconapplication/component/rounded_button.dart';
import 'package:beaconapplication/component/rounded_password_field.dart';
import 'package:beaconapplication/component/rounder_input_field.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform;

import '../../shared/constants.dart';
import '../../shared/constants.dart';
import '../../shared/constants.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import 'register.dart';

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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,

          body: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Text("LOGIN", style: TextStyle(fontWeight: FontWeight.w300),),
                SizedBox(height: size.height * 0.03),
                Text("Welcome to the E-Ettendance",style:
                  TextStyle(fontWeight: FontWeight.w900,fontSize: 20.00,),),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset("assets/images/study.svg",
                height: size.height * 0.30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height * 0.03),
                        RoundedInputField(
                          deco: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            ),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                          validator: (val) => val.isEmpty ? "Enter an email" : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        RoundedPasswordField(
                          validator: (val) => val.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                        ),
//                      RaisedButton(
//                          color: Colors.lightBlueAccent,
//                          child: Text(
//                            'Sign In',
//                            style: TextStyle(color: Colors.black),
//                          ),
//                          onPressed: () async {
//                            if (_formkey.currentState.validate()) {
//
//                              print("Validate");
//                              dynamic result =
//                              await _auth.SignInWithEmailAndPassword(
//                                  email, password);
//                              if (result == null) {
//                                setState(() {
//                                  error =
//                                  "Could  not sign in. Wrong input ";
//
//                                });
//                              }
//                            }
//                          }
//                      ),
                        RoundedButton(
                          text: "LOGIN",
                          press: () async {
                              if (_formkey.currentState.validate()) {

                                print("Validate");
                                dynamic result =
                                await _auth.SignInWithEmailAndPassword(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                    "Could  not sign in. Wrong input ";
                                    print("tok jadi");
                                  });
                                }
                              }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          press: () {
                            widget.toggleView();
                          },
                        ),
//                      SizedBox(height: size.height * 0.03),
//                      TextFormField(
//                        decoration: textInputDecoration.copyWith(hintText: "Password"),
//                        validator: (val) => val.length < 6
//                            ? "Enter a password 6+ chars long"
//                            : null,
//                        obscureText: true,
//
//                      ),
//                      SizedBox(
//                        height: 10.0,
//                      ),
//                      RaisedButton(
//                        color: kPrimaryColor,
//                        child: Text(
//                          'Sign In',
//                          style: TextStyle(color: Colors.black),
//                        ),
//
//                      ),
//                      SizedBox(
//                        height: 10.00,
//                      ),

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
        ),
    );
  }
}
