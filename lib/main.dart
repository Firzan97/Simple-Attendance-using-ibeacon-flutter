import 'package:beaconapplication/model/user.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:flutter/material.dart';
import "package:beaconapplication/screens/wrapper.dart";
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()
        ),
    );
  }
}
