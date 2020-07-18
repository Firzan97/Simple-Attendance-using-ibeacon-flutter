import 'package:beaconapplication/services/auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = "";
  String name = "";
  String password = "";
  String error = "";
  String program = "";
  String matrix = "";
  final List<String> programs = ['CS230', 'CS251', 'CS253'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
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
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                      validator: (val) => val.isEmpty ? "Enter a name" : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "Program",
                      ),
                      items: programs.map((program) {
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
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Matrix Number",
                      ),
                      validator: (val) => val.isEmpty ? "Please Enter Matrix Number" : null,
                      onChanged: (val) {
                        setState(() => matrix = val);
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
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
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          //await _auth.addAdditionalData(name, program);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password, program, name, matrix);
                          if (result == null) {
                            setState(
                                () => error = "Please suply a valid email ");
                          }
                        }
                      },
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
