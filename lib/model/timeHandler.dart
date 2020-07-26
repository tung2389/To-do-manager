import 'package:flutter/material.dart';

class TimeHandler{
  // Use static keyword to use method without creating any instance of class.
  static TimeOfDay fromMaptoTimeOfDay(Map<String, int> time) {
    return TimeOfDay(
      hour: time['hour'],
      minute: time['minute']
    );
  }
  static Map<String, int> fromTimeOfDaytoMap(TimeOfDay time) {
    return Map<String, int>.from({
        'hour': time.hour,
        'minute': time.minute
      });
  }
}