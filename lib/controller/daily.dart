import 'package:cloud_firestore/cloud_firestore.dart';
import './local.dart';
import '../model/daily.dart';

class DailyService {
  final _db = Firestore.instance;

  Future create(DailyTask task) async {
    Map<String, dynamic> newTask = task.toMap();
    newTask['createdAt'] = DateTime.now();
    // We will take the id from firebase which is automatically generated
    newTask.remove('id');
    String uid = await LocalData.getUserId();
    try {
      final DocumentReference taskRef = await _db.collection('user')
                                                .document(uid)
                                                .collection('daily')
                                                .add(newTask);
      newTask['id'] = taskRef.documentID;
      return newTask;
    } catch(e) {
      return null;
    }
  }

  Future<void> update(String taskId, DailyTask task) async {
    String uid = await LocalData.getUserId();
    Map<String, dynamic> newTask = task.toMap();
    try{
      await _db.collection('user') 
        .document(uid)
        .collection('daily')
        .document(taskId)
        .setData(newTask);
    } catch(e) {
      return Future.error(
        'There was an error updating your task'
      );
    }
  }

  Future<void> updateSteps(String taskId, List<String>stepList) async {
    String uid = await LocalData.getUserId();
    try{
      await _db.collection('user') 
        .document(uid)
        .collection('daily')
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

  Future<bool> markAsCompleted(String taskId) async {
    String uid = await LocalData.getUserId();
    try{
      await _db.collection('user')
              .document(uid)
              .collection('daily')
              .document(taskId)
              .updateData({
                'status': 'completed'
              });
      return true;
    } catch(e) {
      return null;
    }
  }

  Future<void> delete(String taskId) async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
              .document(uid)
              .collection('daily')
              .document(taskId)
              .delete();
  }

  // A function return a Future<List<DocumentSnapshot>>, which is _db.collection('user')...getDocuments.then(...)
  Future<List<DocumentSnapshot>> getOverdueTasks() async {
    String uid = await LocalData.getUserId();
    return _db.collection('user')
      .document(uid)
      .collection('daily')
      .where('status', isEqualTo: 'pending')
      .getDocuments().then((snapshots) {
        return snapshots.documents;
      });
  }

  Future<void> deleteOverdue(String taskId) async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
              .document(uid)
              .collection('yesterdayOverdue')
              .document(taskId)
              .delete();
  }

  Future<void> handleYesterdayTasks() async {
    String uid = await LocalData.getUserId();
    return _db.collection('user')
      .document(uid)
      .collection('daily')
      .getDocuments()
      .then((QuerySnapshot data) {
        List<Future> updatingFutures = <Future>[];
        for (DocumentSnapshot document in data.documents) {
          if(document.data['status'] == 'completed') {
            // Reset task's status to pending
            updatingFutures.add(
              document.reference.updateData({
                'status': 'pending'
              })
            );
          }
          else {
            // Add yesterday uncompleted tasks to yesterdayOverdue collection
            _db.collection('user')
              .document(uid)
              .collection('yesterdayOverdue')
              .add(document.data);
          }
        }
        return Future.wait(updatingFutures);
      });
  }

  static List<String> calculateTaskNeedToAddToOverdue() {

  }
}