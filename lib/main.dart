
import 'package:beaconapplication/model/user.dart';
import 'package:beaconapplication/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:beaconapplication/screens/wrapper.dart";
import 'package:provider/provider.dart';




void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  String _beaconResult = 'Not Scanned Yet.';
//  int _nrMessaggesReceived = 0;
//  var isRunning = false;
//  String result, uuid;
//  Map datas;
//
//  final StreamController<String> beaconEventsController =
//  StreamController<String>.broadcast();
//
//  @override
//  void initState() {
//    super.initState();
//    initPlatformState();
//  }
//
//  @override
//  void dispose() {
//    beaconEventsController.close();
//    super.dispose();
//  }
//
//  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    BeaconsPlugin.listenToBeacons(beaconEventsController);
//
//    await BeaconsPlugin.addRegion(
//        "BeaconType1", "909c3cf9-fc5c-4841-b695-380958a51a5a");
//    await BeaconsPlugin.addRegion(
//        "BeaconType2", "6a84c716-0f2a-1ce9-f210-6a63bd873dd9");
//
//
//    beaconEventsController.stream.listen(
//            (data) {
//          if (data.isNotEmpty) {
//            setState(() {
//              _beaconResult = data.toString();
//              _nrMessaggesReceived++;
//              result = _beaconResult;
//              Map datas= jsonDecode(_beaconResult);
//              uuid = datas["macAddress"];
//            });
//            print("Beacons DataReceived: " + data);
//          }
//        },
//        onDone: () {},
//        onError: (error) {
//          print("Error: $error");
//        });
//
//    //Send 'true' to run in background
//    await BeaconsPlugin.runInBackground(true);
//
//    if (Platform.isAndroid) {
//      BeaconsPlugin.channel.setMethodCallHandler((call) async {
//        if (call.method == 'scannerReady') {
//          await BeaconsPlugin.startMonitoring;
//          setState(() {
//            isRunning = true;
//          });
//        }
//      });
//    } else if (Platform.isIOS) {
//      await BeaconsPlugin.startMonitoring;
//      setState(() {
//        isRunning = true;
//      });
//    }
//
//    if (!mounted) return;
//  }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()
        ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.red,
//          title: const Text('Beacons Application'),
//        ),
//        body: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text('$uuid'),
//              Padding(
//                padding: EdgeInsets.all(10.0),
//              ),
//              Text('$_nrMessaggesReceived'),
//              SizedBox(
//                height: 20.0,
//              ),
//             RaisedButton(
//                  onPressed: () async {
//                    if (Platform.isAndroid) {
//                      await BeaconsPlugin.stopMonitoring;
//
//                      setState(() {
//                        isRunning = false;
//                      });
//                    }
//                  },
//                  child: Text('Stop Scanning', style: TextStyle(fontSize: 20)),
//                ),
//
//              SizedBox(
//                height: 20.0,
//              ),
//              /*AlertDialog(
//                title: Text("Thank you for coming"),
//                content: Text("We have some promotion for you"),
//              ),*///
//           RaisedButton(
//                  onPressed: () async {
//                    initPlatformState();
//                    await BeaconsPlugin.startMonitoring;
//
//                    setState(() {
//                      isRunning = true;
//                    });
//                  },
//                  child: Text('Start Scanning', style: TextStyle(fontSize: 20, color: Colors.black)),
//                  color: Colors.lightBlueAccent,
//                ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
}
