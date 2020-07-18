import 'package:beaconapplication/model/attendance.dart';
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
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.redAccent,
              ),
              title: Text(widget.att.status + " ("+ widget.att.studId +")" + " has attend the class", style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ) ),
//              subtitle: Text(widget.user.program),
            ),
          ),
        ],
      ),
    );
  }
}
