import 'package:beaconapplication/model/attendance.dart';
import 'package:beaconapplication/screens/home/user_list.dart';
import 'package:beaconapplication/services/database.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../../model/user.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isRunning = false;

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider<List<Attendance>>.value(
            value: DatabaseService().attendances),
        StreamProvider<List<User>>.value(
            value: DatabaseService().students)
      ],
      child: SafeArea(
        child: Scaffold(
          body: UserList()
        ),
      ),
    );
  }
}
