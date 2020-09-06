import 'package:cloud_firestore/cloud_firestore.dart';
import './local.dart';

class UserService {
  static final CollectionReference userCollection = Firestore.instance.collection('user');

  static Future createUser(String name) async {
    String uid = await LocalData.getUserId();
    return userCollection.document(uid).setData({
      'name': name,
      'lastAccessDay': DateTime.now().day
    });
  }

  static Future<bool> checkNewDay(today) async {
    String uid = await LocalData.getUserId();
    return userCollection.document(uid).get().then((user) {
      if(user.data['lastAccessDay'] != today) {
        return true;
      }
      else {
        return false;
      }
    });
  }

  static Future<void> updatelastAccessDay(newDay) async {
    String uid = await LocalData.getUserId();
    return userCollection.document(uid).setData({
      'lastAccessDay': newDay
    });
  }
}