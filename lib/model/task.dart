import 'package:flutter/material.dart';

class Task {
  String id;
  String name;
  String importance;
  String description;
  List<String> steps;
  List<String> labels;
  String startTime;
  String endTime;
  String createdAt;

  Task({
    @required this.id,
    @required this.name,
    @required this.importance,
    @required this.startTime,
    @required this.endTime,
    @required this.createdAt,
    this.description,
    this.steps,
    this.labels
  });

}

