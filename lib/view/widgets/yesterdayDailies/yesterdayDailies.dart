import 'package:flutter/material.dart';
import '../Task/Daily/daily.dart';
import '../../../model/daily.dart';

class YesterdayDailies extends StatelessWidget {
  final List overdueTasks;
  YesterdayDailies({this.overdueTasks});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Check off any dailies you completed yesterday'),
      contentPadding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20)
        )
      ),
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.height / 1.2,
          child: ListView.builder(
            itemBuilder: (context, index) {
              Map<String, dynamic> rawTask = overdueTasks[index].data;
              rawTask['id'] = overdueTasks[index].documentID; //insert ID to Map task
              DailyTask task = DailyTask.fromMap(rawTask);
              return DailyTaskView(
                task: task,
                parentContext: context,
                mode: 'edit',
              );
            }, 
            itemCount: overdueTasks.length,
          )
        ),
        RaisedButton(
          child: Text(
            'Start a new day!',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue[400],
          onPressed: () => Navigator.pop(context) // Close the dialog
        )
      ],
    );
  }
}