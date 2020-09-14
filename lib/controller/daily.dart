import 'package:cloud_firestore/cloud_firestore.dart';
import './local.dart';
import '../model/daily.dart';

class DailyService {
  static final _db = Firestore.instance;

  static Future create(DailyTask task) async {
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

  static Future<void> update(String taskId, DailyTask task) async {
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

  static Future<void> updateSteps(String taskId, List<String>stepList) async {
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

  static Future<bool> markAsCompleted(String taskId) async {
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

  static Future<void> delete(String taskId) async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
              .document(uid)
              .collection('daily')
              .document(taskId)
              .delete();
  }

  static Future<List<DocumentSnapshot>> getAllDailyTasks() async {
    String uid = await LocalData.getUserId();
    return _db.collection('user')
      .document(uid)
      .collection('daily')
      .getDocuments().then((snapshots) {
        return snapshots.documents;
      });
  }

  static Future<void> deleteOverdue(String taskId) async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
              .document(uid)
              .collection('yesterdayOverdue')
              .document(taskId)
              .delete();
  }

  static Future<void> deleteAllYesterdayOverdue() async{
    String uid = await LocalData.getUserId();
    return _db.collection('user')
      .document(uid)
      .collection('yesterdayOverdue')
      .getDocuments()
      .then((QuerySnapshot data) {
        List<Future> delFutures = <Future>[];
        for (DocumentSnapshot document in data.documents) {
          delFutures.add(
            document.reference.delete()
          );
        }
        return Future.wait(delFutures);
      });
  }

  static Future<void> handleYesterdayTasks(List<DocumentSnapshot> dailyTaskList, List<String> dailyTaskStatus) async {
    String uid = await LocalData.getUserId();
    await deleteAllYesterdayOverdue();
    List<Future> updatingFutures = <Future>[];
    for(int i = 0; i < dailyTaskList.length; i++) {
      DocumentSnapshot document = dailyTaskList[i];
      if(dailyTaskStatus[i] == 'completed') {
        updatingFutures.add(
          document.reference.updateData({
            'status': 'pending'
          })
        );
      }
      else {
        updatingFutures.add(
          _db.collection('user')
            .document(uid)
            .collection('yesterdayOverdue')
            .document(document.documentID)
            .setData(document.data)     
        );
      }
    }
  }
}