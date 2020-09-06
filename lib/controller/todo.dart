import 'package:cloud_firestore/cloud_firestore.dart';
import './local.dart';
import '../model/todo.dart';

class TodoService {
  static final _db = Firestore.instance;

  static Future create(TodoTask task) async {
    Map<String, dynamic> newTask = task.toMap();
    newTask['createdAt'] = DateTime.now();
    // We will take the id from firebase which is automatically generated
    newTask.remove('id');
    String uid = await LocalData.getUserId();
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

  static Future update(String taskId, TodoTask task) async {
    String uid = await LocalData.getUserId();
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

  static Future updateSteps(String taskId, List<String>stepList) async {
    String uid = await LocalData.getUserId();
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

  static Future markAsCompleted(String taskId) async {
    String uid = await LocalData.getUserId();
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
  
  static Future<void> delete(String taskId) async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
              .document(uid)
              .collection('todo')
              .document(taskId)
              .delete();
  }
}