import 'package:beaconapplication/screens/home/user_list.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:beaconapplication/services/database.dart';
import "package:flutter/material.dart";
import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:beacons_plugin/beacons_plugin.dart';
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

  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessaggesReceived = 0;
  var isRunning = false;
  String result, uuid;
  Map datas;



  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    beaconEventsController.close();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    await BeaconsPlugin.addRegion(
        "BeaconType1", "909c3cf9-fc5c-4841-b695-380958a51a5a");
    await BeaconsPlugin.addRegion(
        "BeaconType2", "6a84c716-0f2a-1ce9-f210-6a63bd873dd9");

    beaconEventsController.stream.listen(
        (data) {
          if (data.isNotEmpty) {
            setState(() {
              _beaconResult = data.toString();
              _nrMessaggesReceived++;
              result = _beaconResult;
              Map datas = jsonDecode(_beaconResult);
              uuid = datas["macAddress"];
            });
            print("Beacons DataReceived: " + data);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    //Send 'true' to run in background
    await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          setState(() {
            isRunning = true;
          });
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
      setState(() {
        isRunning = true;
      });
    }

    if (!mounted) return;
  }

  void _attendance() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thank you for coming the class today"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Click OK to close'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // TODO: implement build
    return StreamProvider<List<User>>.value(
      value: DatabaseService().students,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text("Home"),
            elevation: 0.0,
            centerTitle: true,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("Log Out"),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
         body: UserList()),
    );
//        Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(uuid == "C5:4D:36:46:B6:CA" ? 'Bilik JMK 1' : 'No Class Detect'),
//              Padding(
//                padding: EdgeInsets.all(10.0),
//              ),
//              Text('$_nrMessaggesReceived'),
//              SizedBox(
//                height: 20.0,
//              ),
//              RaisedButton(
//                onPressed: () async {
//                  if (Platform.isAndroid) {
//                    await BeaconsPlugin.stopMonitoring;
//
//                    setState(() {
//                      isRunning = true;
//                    });
//                  }
//                },
//                child: Text('Stop Scanning', style: TextStyle(fontSize: 20)),
//              ),
//              SizedBox(
//                height: 20.0,
//              ),
//              RaisedButton(
//                onPressed: () async {
//                  initPlatformState();
//                  await BeaconsPlugin.startMonitoring;
//                  setState(() {
//                    isRunning = true;
//                  });
//                },
//                child: Text('Start Scanning', style: TextStyle(fontSize: 20, color: Colors.black)),
//                color: Colors.lightBlueAccent,
//              ),
//              RaisedButton(
//                onPressed: () async {
//                  if (uuid == "C5:4D:36:46:B6:CA") {
//                    _attendance();
//                  }
//                },
//                child: Text('Submit attendance',
//                    style: TextStyle(fontSize: 20, color: Colors.black)),
//                color: Colors.lightBlueAccent,
//              ),
//              RaisedButton(
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => UserList()),
//                    );
//                  },
//                child: Text('Submit attendance',
//                    style: TextStyle(fontSize: 20, color: Colors.black)),
//                color: Colors.lightBlueAccent,
//              ),
//            ],
//          ),
//        ),
//      );

  }
}
