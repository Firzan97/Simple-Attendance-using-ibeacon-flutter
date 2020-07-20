import 'package:beaconapplication/component/already_have_an_account_acheck.dart';
import 'package:beaconapplication/component/dropdown_input.dart';
import 'package:beaconapplication/component/rounded_button.dart';
import 'package:beaconapplication/component/rounded_password_field.dart';
import 'package:beaconapplication/component/rounder_input_field.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String name = "";
  String password = "";
  String error = "";
  String program = "";
  String matrix = "";
  final List<String> programs = ['CS230', 'CS251', 'CS253'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                "assets/images/study2.svg",
                height: size.height * 0.15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedInputField(
                        deco: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                          hintText: "Name",
                          border: InputBorder.none,
                        ),
                        validator: (val) => val.isEmpty ? "Enter a name" : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      DropDownInput(
                        hintText: "Program",
                        program: programs.map((program) {
                          return DropdownMenuItem(
                            value: program,
                            child: Text("$program"),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => program = val),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        deco: InputDecoration(
                          icon: Icon(
                            Icons.card_membership,
                            color: kPrimaryColor,
                          ),
                          hintText: "Matrix Number",
                          border: InputBorder.none,
                        ),
                        validator: (val) => val.isEmpty ? "Please Enter Matrix Number" : null,
                        onChanged: (val) {
                          setState(() => matrix = val);
                        },

                      ),
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
                      RoundedButton(
                        text: "SIGNUP",
                        press: () async {
                          print("Validate");
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password, program, name, matrix);
                          if (result == null) {
                            setState(() {
                              error = "Please suply a valid email ";
                            });
                          }
                        },
                      ),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          widget.toggleView();
                        },
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
      ),
    );
  }
}
