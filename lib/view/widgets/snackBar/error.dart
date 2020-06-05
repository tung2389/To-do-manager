import 'package:flutter/material.dart';

class ErrorSnackBar {
  final String message;
  ErrorSnackBar({this.message});
  
  SnackBar build() {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
  }
}