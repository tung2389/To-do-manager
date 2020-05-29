import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/task.dart';

final _db = Firestore.instance;

Future createTask(task) async {
  try {
    task.createdAt = DateTime.now();
    final DocumentReference taskRef = await _db.collection('task').add(task);
    task.id = taskRef.documentID;
    return task;
  } catch(e) {
    return Future.error('There wass an error while creating task');
  }
}
