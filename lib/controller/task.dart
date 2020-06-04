import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class TaskService {
  final _db = Firestore.instance;

  Future createTodo(Map<String, dynamic> task) async {
    try {
      task['createdAt'] = DateTime.now();
      // We will take the id from firebase which is automatically generated
      task.remove('id');
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

  Future markAsCompleted(String taskId) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');
      await _db.collection('user')
              .document(uid)
              .collection('todo')
              .document(taskId)
              .updateData({
                'pending': 'completed'
              });
      return true;
    } catch(e) {
      return null;
    }
  }
}