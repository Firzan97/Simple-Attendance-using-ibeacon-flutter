import 'dart:async';
import 'package:beaconapplication/screens/home/user_tile.dart';
import 'package:beaconapplication/services/database.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import '../../model/user.dart';



class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {



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
    final students = Provider.of<List<User>>(context);
    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        return Column(

          children: <Widget>[
            Center(
                child: Container(

                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
                      child: Text(uuid == "C5:4D:36:46:B6:CA" ? 'ITT575 CLASS' : 'No Class Detect', style:
                        TextStyle(
                          fontSize: 20.00,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),),
                    ),

                  ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context,index){
                  if((students[index].matrix.toString()=="2019702237") && (uuid == "C5:4D:36:46:B6:CA")) {
                    DatabaseService(uid: user.uid).updateAttendance();
                  }
                    return UserTile(user: students[index]);

                  }),
            ),
          ],
        );

      }

    );
  }
}
