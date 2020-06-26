import 'package:flutter/material.dart';
import '../model/step.dart';

class Task {
  String id;
  String title;
  String priority;
  String description;
  List<TaskStep> steps;
  List<String> labels;
  String startTime;
  String endTime;
  String status;
  String createdAt;

  Task({
    @required this.id,
    @required this.title,
    @required this.priority,
    @required this.startTime,
    @required this.endTime,
    @required this.createdAt,
    @required this.status,
    this.description,
    this.steps,
    this.labels
  });

  Task.fromMap(Map<String, dynamic> task) {
    id = task['id'];
    title = task['title'];
    priority = task['priority'];
    description = task['description'];
    steps = task['steps']
              .map<TaskStep>((step) => TaskStep.fromMap(step))
              .toList();
    labels = task['labels']
              .map<String>((label) => label.toString())
              .toList();
    startTime = task['startTime'].toString();
    endTime = task['endTime'].toString();
    status = task['status'];
    createdAt = task['createdAt'].toString();
  }

  Map <String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'priority': priority,
    'description': description,
    'steps': steps.map((TaskStep s) => s.toMap()).toList(),
    'labels': labels,
    'startTime': startTime,
    'endTime': endTime,
    'status': status,
    'createdAt': createdAt
  };
}

