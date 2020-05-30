import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../model/task.dart';

class TaskService {
  final _db = Firestore.instance;
  final String uid;
  TaskService({this.uid});

  Future createTodo(task) async {
    try {
      task.createdAt = DateTime.now();
      final DocumentReference taskRef = await _db.collection('user')
                                                .document(uid)
                                                .collection('todo')
                                                .add(task);
      task.id = taskRef.documentID;
      return task;
    } catch(e) {
      return null;
    }
  }
}