import 'package:flutter/material.dart';
import './confirmDelete.dart';

class DropdownTaskOptions extends StatelessWidget {
  final List<String> items;
  final StatefulWidget editor;
  final StatelessWidget viewOnly;
  final Future<void> Function() deleteTask;
  DropdownTaskOptions({this.items, this.editor, this.viewOnly, this.deleteTask});
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
        items: items
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), 
        onChanged: (String newValue) {
          if(newValue == 'Edit') {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return editor;
              }
            );
          }
          else if(newValue == 'View') {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return viewOnly;
              }
            );
          }
          else if(newValue == 'Delete') {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ConfirmDelete(
                  deleteTask: deleteTask
                );
              }
            );
          }
        },
        icon: Icon(Icons.more_vert),
      ),
    );
  }
}