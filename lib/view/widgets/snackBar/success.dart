import 'package:flutter/material.dart';

class SuccessSnackBar {
  final String message;
  SuccessSnackBar({this.message});

  SnackBar build() {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );           
  }
}