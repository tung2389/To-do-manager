import 'package:flutter/material.dart';
import '../../../loadingIndicator/loadingIndicator.dart';
import '../../../dateTime/dateTime.dart';

import '../../label.dart';
import '../../dropdown.dart';
import '../../step.dart';

import '../../../../../controller/todo.dart';

import '../../../../../model/step.dart';
import '../../../../../model/todo.dart';

class TodoCreator extends StatefulWidget {
  TodoCreator({Key key}) : super(key: key);

  @override
  _TodoCreatorState createState() => _TodoCreatorState();
}

class _TodoCreatorState extends State<TodoCreator> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  TodoTask _task = new TodoTask(
    id: '',
    title: '', 
    priority: '', 
    description: '',
    steps: new List<TaskStep>(),
    labels: new List<String>(),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(new Duration(minutes: 30)),
    status: 'pending',
    createdAt: DateTime.now() 
  );

  TaskStep tempStep = TaskStep(
    title: '',
    completed: false
  );
  String tempLabel = '';

  final _stepController = TextEditingController();
  final _labelController = TextEditingController();

  List<Widget> _generateLabelList() {
    List<Widget> labelList = new List<Widget>();
    for(int i = 0; i < _task.labels.length; i++) {
      labelList.add(
        new LabelView(
          label: _task.labels[i]
        )
      );
    }
    return labelList;
  }

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
          child: SingleChildScrollView(
            // controller: _scrollBarController,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter task's title"
                    ),
                    onChanged: (value) {
                      setState(() {
                        _task.title = value;
                      });
                    },
                    validator: (val) => val.isEmpty ? "Field is required" : null,
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter task's description"
                    ),
                    onChanged: (value) {
                      setState(() {
                        _task.description = value;
                      });
                    },
                    validator: (val) => val.isEmpty ? "Field is required" : null,
                  ),
                  SizedBox(height: 10), // Add margin

                  Text('Choose level'),
                  DropDownMenu(
                    changeOption: (value) {
                      setState(() {
                        _task.priority = value;
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
                            //_task.steps.add(tempStep); // We cannot do this because this will add the reference of tempStep.
                            _task.steps.add(TaskStep.clone(tempStep));
                          });
                        _stepController.clear();
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
                              tempStep.title = value;
                            });
                          },
                          controller: _stepController,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return StepView(
                        step: _task.steps[index],
                        updateStep: (bool value) {
                          setState(() {
                            _task.steps[index].completed = value;
                          });
                        },
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
                          _labelController.clear();
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
                          },
                          controller: _labelController,
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: _generateLabelList(),
                  ),
                  SizedBox(height: 10),
                ]
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 15
              ),
              child: RaisedButton(
                child: _loading 
                ? Loading() 
                : Text(
                  'Create new task',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red[400],
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    TodoService.create(_task).whenComplete(() {
                      setState(() {
                        _loading = false;
                      });
                      Navigator.pop(context); // Close the dialog
                    });
                  }
                },
              ),
            ),
            RaisedButton(
              child: Text(
                'Cancel',
                //style: TextStyle(color: Colors.white),
              ),
              //color: Colors.red[400],
              onPressed: () => Navigator.pop(context) // Close the dialog
            )
          ],
        )
      ],
    );
  }
}

