import 'package:flutter/material.dart';

class LabelView extends StatelessWidget {
  final String label;
  const LabelView({this.label, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label)
    );
  }
}