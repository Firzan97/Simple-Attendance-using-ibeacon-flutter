import "package:flutter/material.dart";
import 'package:provider/provider.dart';

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
          Text(widget.user.name + " has Attend the Class"),
          Card(
            margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.redAccent,
              ),
              title: Text(widget.user.name + " ("+ widget.user.matrix +")"),
              subtitle: Text(widget.user.program),
            ),
          ),

        ],
      ),
    );
  }
}
