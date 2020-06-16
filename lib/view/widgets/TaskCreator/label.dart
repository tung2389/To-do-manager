import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String name;
  const Label({this.name, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}