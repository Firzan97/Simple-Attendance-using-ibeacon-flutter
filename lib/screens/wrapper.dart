import 'package:beaconapplication/model/user.dart';
import 'package:beaconapplication/screens/authenticate/authenticate.dart';
import 'package:beaconapplication/screens/authenticate/sign_in.dart';
import "package:flutter/material.dart";
import "package:beaconapplication/screens/home/home.dart";
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate Widget

    final user = Provider.of<User>(context);
    print(user);
    if(user==null)
      {
        return Authenticate();
      }
    else{
      return Home();
    }

  }
}
