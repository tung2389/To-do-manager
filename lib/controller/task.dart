import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class TaskService {
  final _db = Firestore.instance;

  Future createTodo(Map<String, dynamic> task) async {
    try {
      task['createdAt'] = DateTime.now();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');
      final DocumentReference taskRef = await _db.collection('user')
                                                .document(uid)
                                                .collection('todo')
                                                .add(task);
      task['id'] = taskRef.documentID;
      return task;
    } catch(e) {
      return null;
    }
  }
}