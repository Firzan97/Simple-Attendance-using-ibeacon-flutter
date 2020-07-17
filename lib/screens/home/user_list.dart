import 'package:beaconapplication/screens/home/user_tile.dart';
import 'package:beaconapplication/services/database.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../model/user.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final students = Provider.of<List<User>>(context);
    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context,index){
              if(students[index].matrix==snapshot.data.matrix) {
                //await DatabaseService(uid: user.uid).updateAttendance();
                return UserTile(user: students[index]);
              }
            });
      }

    );
  }
}
