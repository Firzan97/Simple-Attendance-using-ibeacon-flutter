import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../model/user.dart';
import '../../model/user.dart';

class UserTile extends StatefulWidget {
  final User user;

  UserTile({this.user});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {

  User search(){
    User dummy = widget.user;
       bool a = dummy.matrix == "2019702237";
       if(dummy.matrix == "2019702237") {
         return dummy;
       }
       else{
         return dummy;
       }

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Text(widget.user.name + " has Attend the Class"),
          Text(search().matrix),
          Card(
            margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.redAccent,
              ),
//              title: Text(search().name + " ("+ search().matrix +")"),
//              subtitle: Text(search().program),
            ),
          ),

        ],
      ),
    );
  }
}
