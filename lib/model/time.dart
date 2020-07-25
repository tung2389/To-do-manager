import 'package:flutter/material.dart';

class TimeOnly{
  int hour;
  int minute; 

  TimeOnly({
    @required this.hour,
    @required this.minute
  });

  Map<String, dynamic> toMap() => {
    'hour': hour,
    'minute': minute 
  };
  TimeOnly.fromMap(Map<String, dynamic> step) {
    hour = step['hour'];
    minute = step['minute'];
  }
  TimeOnly.clone(TimeOnly step) { // Method for deep copy of class
    hour =  step.hour;
    minute = step.minute;
  }
}