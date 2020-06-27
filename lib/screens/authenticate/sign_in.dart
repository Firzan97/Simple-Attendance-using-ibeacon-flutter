import 'package:beaconapplication/services/auth.dart';
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

final AuthService _auth = AuthService();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("SIGN IN"),
        elevation: 0.0,
      ),
      body: Container(
        padding:  EdgeInsets.symmetric(vertical: 20.00, horizontal: 50.00),
        child: RaisedButton(
          child: Text("Sign in"),
          onPressed: ()async{
                 dynamic result = await _auth.signInAnon();
                 if (result==null)
                   {
                     print('Error Signing In');
                   }
                 else
                   {
                     print("Signed In");
                     print(result);
                   }
          },
        )
      ),
    );
  }
}
