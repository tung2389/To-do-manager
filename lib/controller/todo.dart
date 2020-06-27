import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './local.dart';
import '../model/task.dart';

class TaskService {
  final _db = Firestore.instance;

  Future createTodo(Task task) async {
    Map<String, dynamic> newTask = task.toMap();
    newTask['createdAt'] = DateTime.now();
    // We will take the id from firebase which is automatically generated
    newTask.remove('id');
    String uid = await getUserId();
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

  Future updateTask(String taskId, Task task) async {
    String uid = await getUserId();
    Map<String, dynamic> newTask = task.toMap();
    try{
      await _db.collection('user') 
        .document(uid)
        .collection('todo')
        .document(taskId)
        .setData(newTask);
    } catch(e) {
      return Future.error(
        'There was an error updating your task'
      );
    }
  }

  Future updateSteps(String taskId, List<String>stepList) async {
    String uid = await getUserId();
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
    String uid = await getUserId();
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