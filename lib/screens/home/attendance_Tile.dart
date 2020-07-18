import 'package:beaconapplication/model/attendance.dart';
import 'package:beaconapplication/model/user.dart';
import 'package:beaconapplication/services/database.dart';
import 'package:flutter/material.dart';

class AttendanceTile extends StatefulWidget {

  final Attendance att;
  AttendanceTile({this.att});
  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}




class _AttendanceTileState extends State<AttendanceTile> {

   User fecthData(){
    String id = widget.att.studId;

}

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User>(
      //function untuk retrieve user by user id in attendance database
        stream: DatabaseService(uid: widget.att.studId).userData,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.redAccent,
                    ),
                    title: Text(
                        snapshot.data.name +
                            " (" +
                            snapshot.data.matrix +
                            ")" +
                            " has attend the class",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
//              subtitle: Text(widget.user.program),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
