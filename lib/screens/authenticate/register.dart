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
     String password="";
     String error = "";

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
                onPressed: (){
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
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
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
                          dynamic result = await _auth
                              .resgisterWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(
                                () => error = "Please suply a valid email ");
                            ;
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
