import 'package:flutter/material.dart';
import 'package:to_do_manager/view/widgets/TaskCreator/label.dart';
import '../dateTime/dateTime.dart';
import './dropdown.dart';
import '../loadingIndicator/loadingIndicator.dart';
import './step.dart';
import '../../../controller/todo.dart';
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
    title: '', //ok
    priority: 'normal', //ok
    description: '',//ok
    steps: new List<TaskStep>(),
    labels: new List<String>(),
    startTime: '',//ok
    endTime: '',//ok
    status: 'pending',//ok
    createdAt: '' //ok
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
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollBarController,
            child: ListView(
              controller: _scrollBarController,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's title"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _task.title = value;
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

