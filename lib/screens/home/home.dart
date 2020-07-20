import 'dart:async';
import 'dart:convert';

import 'package:beaconapplication/model/attendance.dart';
import 'package:beaconapplication/screens/home/user_list.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:beaconapplication/services/database.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import "package:flutter/material.dart";
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import '../../model/user.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  var isRunning = false;
//  void _attendance() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text("Thank you for coming the class today"),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text('Click OK to close'),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("OK"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//        );
//      }
//    );
//  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    // TODO: implement build
    return MultiProvider(
      providers: [
        StreamProvider<List<Attendance>>.value(
            value: DatabaseService().attendances),
        StreamProvider<List<User>>.value(
            value: DatabaseService().students)
      ],
      child: SafeArea(
        child: Scaffold(
//          appBar: AppBar(
//            backgroundColor: kPrimaryColor,
//            title: Text("Home"),
//            elevation: 0.0,
//            centerTitle: true,
//            actions: <Widget>[
//              FlatButton.icon(
//                icon: Icon(Icons.person),
//                label: Text("Log Out"),
//                onPressed: () async {
//// adda error , kalau tambah second time login dia tak detect beacon dah
//                 if (Platform.isAndroid) {
//                      await BeaconsPlugin.stopMonitoring;
//
//                      setState(() {
//                        isRunning = true;
//                      });
//                    }
//                  await _auth.signOut();
//                },
//              )
//            ],
//          ),
           body: UserList()

        ),
      ),

    );
//

//    return Scaffold(
//          appBar: AppBar(
//            backgroundColor: Colors.redAccent,
//            title: Text("Home"),
//            elevation: 0.0,
//            centerTitle: true,
//            actions: <Widget>[
//              FlatButton.icon(
//                icon: Icon(Icons.person),
//                label: Text("Log Out"),
//                onPressed: () async {
//                  await _auth.signOut();
//                },
//              )
//            ],
//          ),
////         body: UserList()
//          body: Center(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(uuid == "C5:4D:36:46:B6:CA" ? 'Bilik JMK 1' : 'No Class Detect'),
//                Padding(
//                  padding: EdgeInsets.all(10.0),
//                ),
//                Text('$_nrMessaggesReceived'),
//                SizedBox(
//                  height: 20.0,
//                ),
//                RaisedButton(
//                  onPressed: () async {
//                    if (Platform.isAndroid) {
//                      await BeaconsPlugin.stopMonitoring;
//
//                      setState(() {
//                        isRunning = true;
//                      });
//                    }
//                  },
//                  child: Text('Stop Scanning', style: TextStyle(fontSize: 20)),
//                ),
//                SizedBox(
//                  height: 20.0,
//                ),
//                RaisedButton(
//                  onPressed: () async {
//                    initPlatformState();
//                    await BeaconsPlugin.startMonitoring;
//                    setState(() {
//                      isRunning = true;
//                    });
//                  },
//                  child: Text('Start Scanning', style: TextStyle(fontSize: 20, color: Colors.black)),
//                  color: Colors.lightBlueAccent,
//                ),
//                RaisedButton(
//                  onPressed: () async {
//                    if (uuid == "C5:4D:36:46:B6:CA") {
//                      _attendance();
//                    }
//                  },
//                  child: Text('Submit attendance',
//                      style: TextStyle(fontSize: 20, color: Colors.black)),
//                  color: Colors.lightBlueAccent,
//                ),
//                RaisedButton(
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => UserList()),
//                    );
//                  },
//                  child: Text('Submit attendance',
//                      style: TextStyle(fontSize: 20, color: Colors.black)),
//                  color: Colors.lightBlueAccent,
//                ),
//              ],
//            ),
//          ),
//    );

  }
}
