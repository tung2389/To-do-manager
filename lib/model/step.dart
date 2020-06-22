import 'package:flutter/material.dart';

class TaskStep{
  String title;
  bool completed; 

  TaskStep({
    @required this.title,
    @required this.completed
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'completed': completed 
  };
  TaskStep.fromMap(Map<String, dynamic> step) {
    title = step['title'];
    completed = step['completed'];
  }
  TaskStep.clone(TaskStep step) { // Method for deep copy of class
    title =  step.title;
    completed = step.completed;
  }
}