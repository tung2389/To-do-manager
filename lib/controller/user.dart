import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String uid;
  UserService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future createUser(String name)  {
    return userCollection.document(uid).setData({
      'name': name,
    });
    // userCollection.document(uid).collection('daily');
    // userCollection.document(uid).collection('todo');
  }
}