import "package:flutter/material.dart";
import '../../model/user.dart';

class UserTile extends StatefulWidget {
  final User user;

  UserTile({this.user});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {


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
              title: Text(widget.user.name + " ("+ widget.user.matrix +")" + " has attend the class", style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ) ),
              subtitle: Text(widget.user.program),
            ),
          ),
        ],
      ),
    );
  }
}
