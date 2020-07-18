
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference studentInfo =
      Firestore.instance.collection('students');

  final CollectionReference attendance = Firestore.instance.collection('attendances');

  Future updateUserData(String name, String program, String matrix) async {
    return await studentInfo.document(uid).setData({
      'name': name,
      'program': program,
      'matrik': matrix,
    });
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return User(
        name:  doc.data['name'] ?? '',
        program: doc.data['program'] ?? '',
        matrix: doc.data['matrik'] ?? ''
      );
    }).toList();
  }

  User _userDataFromSnapShot(DocumentSnapshot snapshot){
    return User(
      uid: uid,
      name: snapshot.data['name'],
      program: snapshot.data['program'],
      matrix: snapshot.data['matrik'],
    );
  }

  Stream<List<User>> get students {
    return studentInfo.snapshots().map(_userListFromSnapshot);
  }

  Stream<User> get userData{
    return studentInfo.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

  //automatic attendance
  Future updateAttendance()async {
    return await attendance.document(uid).setData({
      'status' : "attended" ,
       'student': "/students/"+uid
    });

  }
}
