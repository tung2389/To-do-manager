import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final void Function(String field, dynamic value) changeOption;
  DropDownMenu({this.changeOption});

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = 'normal';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.changeOption('importance', newValue);
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