import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final String defaultValue;
  final void Function(dynamic value) changeOption;
  DropDownMenu({this.defaultValue, this.changeOption});

  @override
  _DropDownMenuState createState() => _DropDownMenuState(defaultValue);
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _defaultValue;
  _DropDownMenuState(String value) {
    _defaultValue = value;
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _defaultValue,
      onChanged: (String newValue) {
        setState(() {
          _defaultValue = newValue;
        });
        widget.changeOption(newValue);
      },
      items: <String>['trivial', 'normal', 'important', 'essential']
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
      }).toList(),
    );
  }
}