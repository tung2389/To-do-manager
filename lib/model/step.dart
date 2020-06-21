import 'package:flutter/material.dart';

class TaskStep{
  String name;
  bool completed; 

  TaskStep({
    @required this.name,
    @required this.completed
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'completed': completed 
  };
  TaskStep.fromMap(Map<String, dynamic> step) {
    name = step['name'];
    completed = step['completed'];
  }
  TaskStep.clone(TaskStep step) { // Method for deep copy of class
    name =  step.name;
    completed = step.completed;
  }
}