import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String uid;
  UserService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future createUser(String name, List daily, List todo)  {
    userCollection.document(uid).setData({
      'name': name,
      'daily': daily,
      'todo': todo
    });
  }
}