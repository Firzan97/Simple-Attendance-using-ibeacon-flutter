import 'package:beaconapplication/model/attendance.dart';
import 'package:beaconapplication/model/user.dart';
import 'package:beaconapplication/services/database.dart';
import 'package:beaconapplication/shared/constants.dart';
import 'package:beaconapplication/shared/loading.dart';
import 'package:flutter/material.dart';

class AttendanceTile extends StatefulWidget {
  final Attendance att;

  AttendanceTile({this.att});

  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      //function untuk retrieve user by user id in attendance database
      stream: DatabaseService(uid: widget.att.studId).userData,
      builder: (context, snapshot) {
      if (snapshot.data == null)
      {
        return Loading();
      }
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              shadowColor: Colors.white,
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15.0,
                  backgroundColor: kSecondaryColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  snapshot.data.name + " (" + snapshot.data.matrix + ")" + " has attend the class",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
                ),
              ),
            ),
          ],
        ),
      );
  }
);
  }
}
