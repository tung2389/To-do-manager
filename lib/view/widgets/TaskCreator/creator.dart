import 'package:flutter/material.dart';
import '../dateTime/dateTime.dart';
import './dropdown.dart';
import '../loadingIndicator/loadingIndicator.dart';
import './step.dart';
import '../../../controller/task.dart';
import '../../../model/task.dart';
import '../../../model/step.dart';

class CreatorDialog extends StatefulWidget {
  CreatorDialog({Key key}) : super(key: key);

  @override
  _CreatorDialogState createState() => _CreatorDialogState();
}

class _CreatorDialogState extends State<CreatorDialog> {
  final TaskService _taskService = new TaskService();
  bool loading = false;
  final ScrollController _scrollBarController = ScrollController();

  Task _task = new Task(
    id: '',
    name: '', //ok
    importance: '', //ok
    description: '',//ok
    steps: new List<TaskStep>(),
    labels: new List<String>(),
    startTime: '',//ok
    endTime: '',//ok
    status: 'pending',//ok
    createdAt: '' //ok
  );

  TaskStep tempStep = TaskStep(
    name: '',
    completed: false
  );
  String tempLabel = '';

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
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollBarController,
            child: ListView(
              controller: _scrollBarController,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's name"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _task.name = value;
                    });
                  },
                ),

                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's description"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _task.description = value;
                    });
                  },
                ),
                SizedBox(height: 10), // Add margin

                Text('Choose level'),
                DropDownMenu(
                  changeOption: (value) {
                    setState(() {
                      _task.importance = value;
                    });
                  }
                ),
                SizedBox(height: 20), // Add margin

                Text('Start time'),
                BasicDateTimeField(
                  onChanged: (value) {
                    setState(() {
                      _task.startTime = value;
                    });
                  },
                ),
                SizedBox(height: 10),

                Text('End time'),
                BasicDateTimeField(
                  onChanged: (value) {
                    setState(() {
                      _task.endTime = value;
                    });
                  }
                ),
                SizedBox(height: 10),
                Text('Steps'),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      tooltip: 'Add new steps',
                      onPressed: () {
                        setState(() {
                          _task.steps.add(tempStep);
                        });
                      },
                    ),
                    Expanded( // We need expanded so the textfield take the remaining space of row
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add more step"
                        ),
                        onChanged: (value) {
                          setState(() {
                            tempStep.name = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return StepView(
                      step: _task.steps[index]
                    );
                  },
                  itemCount: _task.steps.length,
                  shrinkWrap: true,
                ),
                SizedBox(height: 10),

                Text('Categories'),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      tooltip: 'Add labels',
                      onPressed: () {
                        setState(() {
                          _task.labels.add(tempLabel);
                        });
                      }
                    ),
                    Expanded( // We need expanded so the textfield take the remaining space of row
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add new label"
                        ),
                        onChanged: (value) {
                          setState(() {
                            tempLabel = value;
                          });
                        }
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
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