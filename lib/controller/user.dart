import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String uid;
  UserService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future createUser(String name) {
    return userCollection.document(uid).setData({
      'name': name,
      'lastAccessDay': DateTime.now().day
    });
  }

  Future<bool> checkNewDay(today) {
    return userCollection.document(uid).get().then((user) {
      if(user.data['lastAccessDay'] != today) {
        return true;
      }
      else {
        return false;
      }
    });
  }

  Future<void> updatelastAccessDay(newDay) {
    return userCollection.document(uid).setData({
      'lastAccessDay': newDay
    });
  }
}