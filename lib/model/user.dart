import 'package:flutter/material.dart';

class User {
  String uid;
  String name;
  int lastAccessDay;

  User({
    @required this.uid, 
    @required this.name, 
    @required this.lastAccessDay
  });

  void updateUser(String newuid, String newname) {
    uid = newuid;
    name = newname;
  }
}