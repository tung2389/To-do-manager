import 'package:flutter/material.dart';
import '../dateTime/dateTime.dart';
import './dropdown.dart';
import '../loadingIndicator/loadingIndicator.dart';
import '../../../controller/task.dart';
import '../../../model/task.dart';

// List <String> _fields = [
//   'id',
//   'name', 
//   'importance', 
//   'description', 
//   'steps', 
//   'labels', 
//   'startTime', 
//   'endTime', 
//   'createdAt'
// ]; 

class CreatorDialog extends StatefulWidget {
  CreatorDialog({Key key}) : super(key: key);

  @override
  _CreatorDialogState createState() => _CreatorDialogState();
}

class _CreatorDialogState extends State<CreatorDialog> {
  final TaskService _taskService = new TaskService();
  bool loading = false;
  // void _buildFields() {
  //   List<Widget> fieldWidgets  = [];
  //   for (String field in _fields) {
  //     fieldWidgets.add(

  //     )
  //   }
  // }

  void _onChange(String field, dynamic value) {
    _task[field] = value;
    setState(() {
      _task = _task;
    });
  }

  Map <String, dynamic> _task = new Task(
    id: '',
    name: '', //ok
    importance: '', //ok
    description: '',//ok
    steps: [],
    labels: [],
    startTime: '',//ok
    endTime: '',//ok
    status: 'pending',//ok
    createdAt: '' //ok
  ).toMap();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
      contentPadding: EdgeInsets.all(24.0),
      title: Text('Create new task'),
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter task's name"
                ),
                onChanged: (value) =>_onChange('name', value),
              ),

              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter task's description"
                ),
                onChanged: (value) =>_onChange('description', value),
              ),
              SizedBox(height: 10), // Add margin

              Text('Choose level'),
              DropDownMenu(
                changeOption: _onChange
              ),
              SizedBox(height: 20), // Add margin

              Text('Start time'),
              BasicDateTimeField(
                onChanged: _onChange,
                field: 'startTime'
              ),
              SizedBox(height: 10),

              Text('End time'),
              BasicDateTimeField(
                onChanged: _onChange,
                field: 'endTime'
              ),
              SizedBox(height: 10),

              Text('Steps'),
              SizedBox(height: 10),

              Text('Categories'),
              SizedBox(height: 10),
            ],
          ),
        ),
        RaisedButton(
          child: loading 
          ? Loading() 
          : Text(
            'Create new task',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red[400],
          onPressed: () {
            setState(() {
              loading = true;
            });
            _taskService.createTodo(_task);
             Navigator.pop(context); // Close the dialog
          },
        )
      ],
    );
  }
}