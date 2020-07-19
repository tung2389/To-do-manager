import 'package:flutter/material.dart';
import '../../dateTime/dateTime.dart';

import '../label.dart';
import '../dropdown.dart';
import '../step.dart';

import '../../../../model/task.dart';

class ViewOnly extends StatelessWidget {
  final Task task;
  const ViewOnly({this.task});

  List<Widget> _generateLabelList() {
    List<Widget> labelList = new List<Widget>();
    for(int i = 0; i < task.labels.length; i++) {
      labelList.add(
        new LabelView(
          label: task.labels[i]
        )
      );
    }
    return labelList;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(task.title),
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
                  initialValue: task.title,
                  enabled: false,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter task's description"
                  ),
                  initialValue: task.description,
                  enabled: false,
                ),
                SizedBox(height: 10), // Add margin

                Text('Choose level'),
                DropDownMenu(
                  defaultValue: task.priority,
                  enabled: false,
                ),
                SizedBox(height: 20), // Add margin

                Text('Start time'),
                BasicDateTimeField(
                  initialValue: task.startTime,
                  enabled: false,
                ),
                SizedBox(height: 10),

                Text('End time'),
                BasicDateTimeField(
                  initialValue: task.endTime,
                  enabled: false,
                ),
                SizedBox(height: 10),
                Text('Steps'),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return StepView(
                      step: task.steps[index],
                    );
                  },
                  itemCount: task.steps.length,
                  shrinkWrap: true,
                ),
                SizedBox(height: 10),

                Text('Categories'),

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
      ],
    );
  }
}