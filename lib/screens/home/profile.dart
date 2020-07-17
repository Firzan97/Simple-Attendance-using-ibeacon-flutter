import 'package:beaconapplication/services/database.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../model/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<User>
      ( stream: DatabaseService(uid: user.uid).userData,
        builder: (context,snapshot){
        if(snapshot.hasData){
          User u = snapshot.data;
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.redAccent,
                ),
                title: Text(user.name + " ("+ user.matrix +")"),
                subtitle: Text(user.program),
              ),
            ),
          );
        }
        },
    );
  }
}
