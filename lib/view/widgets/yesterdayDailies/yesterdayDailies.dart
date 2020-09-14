import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Task/Daily/daily.dart';
import '../../../model/daily.dart';
import '../loadingIndicator/loadingIndicator.dart';

import '../../../controller/user.dart';
import '../../../controller/daily.dart';

class YesterdayDailies extends StatefulWidget {
  final List<DocumentSnapshot> dailyTaskList;
  final List<Map<String, dynamic>> overdueTasks;
  final List<String> dailyTaskStatus;
  final void Function(int index, String value) changeTaskStatus;
  YesterdayDailies({
    this.dailyTaskList, 
    this.overdueTasks, 
    this.dailyTaskStatus,
    this.changeTaskStatus
  });

  @override
  _YesterdayDailiesState createState() => _YesterdayDailiesState();
}

class _YesterdayDailiesState extends State<YesterdayDailies> {
  bool _loading = false;
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
              Map<String, dynamic> rawTask = widget.overdueTasks[index];
              DailyTask task = DailyTask.fromMap(rawTask);
              return DailyTaskView(
                task: task,
                taskIndex: rawTask['index'],
                parentContext: context,
                mode: 'checkOff',
                changeTaskStatus: widget.changeTaskStatus
              );
            }, 
            itemCount: widget.overdueTasks.length,
          )
        ),
        RaisedButton(
          child: _loading 
          ? Loading() 
          : Text(
            'Start a new day!',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue[400],
          onPressed: () {
            setState(() {
              _loading = true;
            });
            Future.wait([
              UserService.updatelastAccessDay(DateTime.now().day),
              DailyService.handleYesterdayTasks(widget.dailyTaskList, widget.dailyTaskStatus)
            ]).whenComplete(() {
                Navigator.pop(context);
              });
          } // Close the dialog
        )
      ],
    );
  }
}