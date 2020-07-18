import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String program;
  final String matrix;

  User({this.uid, this.name, this.program,this.matrix});

  String getMatrix(){
    return this.matrix;
  }
}

class UserData {
  final String uid;
  final String name;
  final Timestamp date;
  final String kelas;

  UserData({this.uid, this.name, this.date, this.kelas});
}
