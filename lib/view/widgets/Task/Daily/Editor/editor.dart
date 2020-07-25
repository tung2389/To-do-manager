import 'package:flutter/material.dart';
import '../../../loadingIndicator/loadingIndicator.dart';
import '../../../dateTime/dateTime.dart';

import '../../label.dart';
import '../../dropdown.dart';
import '../../step.dart';

import '../../../../../controller/daily.dart';

import '../../../../../model/step.dart';
import '../../../../../model/daily.dart';

class DailyEditor extends StatefulWidget {
  final DailyTask task;
  final BuildContext parentContext;
  DailyEditor({this.task, this.parentContext}) : super(key: Key(task.id));
  // TaskView({this.task}) : super(key: task);

  @override 
  // Pass task property from StatefulWidget to the State widget
  _DailyEditorState createState() => _DailyEditorState(task);
}

class _DailyEditorState extends State<DailyEditor> {
  DailyTask _task;
  _DailyEditorState(DailyTask task) {
    _task = task;
  }
  bool _loading = false;

  final _scrollBarController = ScrollController();
  final _stepController = TextEditingController();
  final _labelController = TextEditingController();
  final DailyService _dailyService = new DailyService();

  TaskStep tempStep = TaskStep(
    title: '',
    completed: false
  );
  String tempLabel = '';

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
      title: Text('Edit this task'),
        // '${task['title']}',
        // style: TextStyle(
        //   fontSize: 18,
        //   color: Colors.white
        // ),
      //),
      // contentPadding: EdgeInsets.symmetric(
      //   horizontal:15,
      //   vertical: 10
      // ),
      contentPadding: EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20)
        )
      ),
      //backgroundColor: Colors.blue[500],
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's title"
                  ),
                  initialValue: _task.title,
                  onChanged: (value) {
                    setState(() {
                      _task.title = value;
                    });
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's description"
                  ),
                  initialValue: _task.description,
                  onChanged: (value) {
                    setState(() {
                      _task.description = value;
                    });
                  },
                ),
                SizedBox(height: 10), // Add margin

                Text('Choose level'),
                DropDownMenu(
                  defaultValue: _task.priority,
                  changeOption: (value) {
                    setState(() {
                      _task.priority = value;
                    });
                  }
                ),
                SizedBox(height: 20), // Add margin

                Text('Start time'),
                BasicDateTimeField(
                  initialValue: _task.startTime,
                  onChanged: (value) {
                    setState(() {
                      _task.startTime = value;
                    });
                  }
                ),
                SizedBox(height: 10),

                Text('End time'),
                BasicDateTimeField(
                  initialValue: _task.endTime,
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
                          _task.steps.add(TaskStep.clone(tempStep));
                        });
                      _stepController.clear();
                      },
                    ),
                    Expanded( // We need expanded so the textfield take the remaining space of row
                      child: TextFormField(
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
                      child: TextFormField(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 15
              ),
              child: RaisedButton(
                child: _loading 
                ? Loading() 
                : Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red[400],
                onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  _dailyService.update(_task.id, _task).whenComplete(() {
                    setState(() {
                      _loading = false;
                    });    
                    Navigator.pop(context); // Close the dialog   
                  });
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