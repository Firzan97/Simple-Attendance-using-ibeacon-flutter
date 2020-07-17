import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference studentInfo =
      Firestore.instance.collection('students');

  Future updateUserData(String name, String program) async {
    return await studentInfo.document(uid).setData({
      'name': name,
      'program': program,
    });
  }
}
