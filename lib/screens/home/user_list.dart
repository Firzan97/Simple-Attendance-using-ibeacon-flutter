import 'dart:async';
import 'package:beaconapplication/component/rounded_button.dart';
import 'package:beaconapplication/model/attendance.dart';
import 'package:beaconapplication/screens/home/attendance_Tile.dart';
import 'package:beaconapplication/screens/home/user_tile.dart';
import 'package:beaconapplication/services/database.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import '../../model/user.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final AuthService _auth = AuthService();
  bool loading = false;
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

    BeaconsPlugin.addRegion("myBeacon", "01022022-f88f-0000-00ae-9605fd9bb620")
        .then((result) {
      print(result);
    });
    //Send 'true' to run in background
//    await BeaconsPlugin.runInBackground(true);


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



    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
    }

    if (!mounted) return;
  }

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
    final students = Provider.of<List<User>>(context) ?? [];

    final user = Provider.of<User>(context);
    final attendances = Provider.of<List<Attendance>>(context) ?? [];

    void _updateAttend(AsyncSnapshot<User> snapshot) {
      int index = students.length;

      for (int i = 0; i < index; i++) {
        if (students[i].matrix.toString() == snapshot.data.matrix &&
            uuid == "C5:4D:36:46:B6:CA") {
          DatabaseService(uid: user.uid).updateAttendance();
        }
      }
    }
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: size.width,

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          uuid == "C5:4D:36:46:B6:CA"
                              ? 'ITT575 CLASS'
                              : 'No Class Detect',
                          style: TextStyle(
                            fontSize: 18.00,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      RoundedButton(
                        press: () async {
                          if (Platform.isAndroid) {
                            await BeaconsPlugin.stopMonitoring;

                            setState(() {
                              isRunning = true;
                            });
                          }
                          await _auth.signOut();

                        },
                        text: "Log Out",
                        color: kThirdColor,
                      ),
                      RoundedButton(
                        press: () async {
                          initPlatformState();
                          await BeaconsPlugin.startMonitoring;
                          setState(() {
                            isRunning = true;
                          });

                        },
                        text: "Find Class",
                        color: kThirdColor,
                      ),
                      SizedBox(height: 20.0,)
                    ],
                  ),
                ),
              ),
              //list view untuk compare & update database
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: students.length,
              //     itemBuilder: (context, index) {
              //       if ((students[index].matrix.toString() ==
              //               snapshot.data.matrix) &&
              //           (uuid == "C5:4D:36:46:B6:CA")) {
              //         DatabaseService(uid: user.uid).updateAttendance();
              //       }
              //      return UserTile(user: students[index]);
              //      return AttendanceTile(att: attendances[index]);
              //     }
              //   ),
              // ),
              //list view untuk display attendances

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 7,
                        blurRadius: 10,
                      )
                    ]
                  ),
                  child: ListView.builder(
                      itemCount: attendances.length,
                      itemBuilder: (context, index) {
                        if(uuid == "C5:4D:36:46:B6:CA") {
                          _updateAttend(snapshot);
                          return AttendanceTile(att: attendances[index]);
                        }

                      }),
                ),
              ),

            ],
          );
        });
  }
}
