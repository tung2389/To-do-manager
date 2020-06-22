import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';
// import 'package:flutter/material.dart';

class TaskService {
  final _db = Firestore.instance;

  Future createTodo(Task task) async {
    Map<String, dynamic> newTask = task.toMap();
    newTask['createdAt'] = DateTime.now();
    // We will take the id from firebase which is automatically generated
    newTask.remove('id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    try {
      final DocumentReference taskRef = await _db.collection('user')
                                                .document(uid)
                                                .collection('todo')
                                                .add(newTask);
      newTask['id'] = taskRef.documentID;
      return newTask;
    } catch(e) {
      return null;
    }
  }

  Future updateSteps(String taskId, List<String>stepList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    try{
      await _db.collection('user') 
        .document(uid)
        .collection('todo')
        .document(taskId)
        .updateData({
          'steps': stepList
        });
    } catch(e) {
      return Future.error(
        'There was an error updating your steps'
      );
    }
    
  }

  Future markAsCompleted(String taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    try{
      await _db.collection('user')
              .document(uid)
              .collection('todo')
              .document(taskId)
              .updateData({
                'status': 'completed'
              });
      return true;
    } catch(e) {
      return null;
    }
  }
}