import 'package:flutter/material.dart';
import '../loadingIndicator/loadingIndicator.dart';

class ConfirmDelete extends StatefulWidget {
  final void Function(String taskId) deleteTask;
  ConfirmDelete({this.deleteTask});
  @override
  _ConfirmDeleteState createState() => _ConfirmDeleteState();
}

class _ConfirmDeleteState extends State<ConfirmDelete> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Do you want to delete this task?'),
      contentPadding: EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20)
        )
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 15
              ),
              child: RaisedButton(
                child: Text(
                  'Cancel',
                  //style: TextStyle(color: Colors.white),
                ),
                //color: Colors.red[400],
                onPressed: () => Navigator.pop(context) // Close the dialog
              )
            ),
            RaisedButton(
              child: _loading 
              ? Loading() 
              : Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red[600],
              onPressed: () {
                setState(() {
                  _loading = true;
                });
                
              },
            ),
          ],
        )
      ],
    ); 
  }
}