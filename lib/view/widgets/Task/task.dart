import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  final Map<String, dynamic> task;
  TaskView({Key key, this.task}) : super(key: key);
  // TaskView({this.task}) : super(key: task);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool checked = false;

  void _showContent(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('${widget.task['name']}'),
          children: <Widget>[
            Text('${widget.task['description']}'),
            Text('${widget.task['importance']}')
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showContent(context),
      child: Card(
        child: Row(
          children: <Widget>[
            Checkbox(
              value:checked, 
              onChanged: (bool value) {
                setState(() {
                  checked = value;
                });
              },
              // activeColor: ,
            ),
            Text(
              '${widget.task['name']}'
            ),  
          ],
        )
      )
    );
  }
}