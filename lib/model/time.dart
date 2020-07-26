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
  TimeOnly.fromMap(Map<String, dynamic> time) {
    hour = time['hour'];
    minute = time['minute'];
  }
  TimeOnly.fromTimeOfDay(TimeOfDay time) {
    hour = time.hour;
    minute = time.minute;
  }
  TimeOnly.clone(TimeOnly time) { // Method for deep copy of class
    hour =  time.hour;
    minute = time.minute;
  }
}