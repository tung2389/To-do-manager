import 'package:flutter/material.dart';
import '../Task/Daily/daily.dart';
import '../../../model/daily.dart';
import '../loadingIndicator/loadingIndicator.dart';

class YesterdayDailies extends StatefulWidget {
  final List overdueTasks;
  final Future<void> Function() handleYesterdayDailies;
  final Future<void> Function() updateLastAccessDay;
  YesterdayDailies({this.overdueTasks, this.handleYesterdayDailies ,this.updateLastAccessDay});

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
              Map<String, dynamic> rawTask = widget.overdueTasks[index].data;
              rawTask['id'] = widget.overdueTasks[index].documentID; //insert ID to Map task
              DailyTask task = DailyTask.fromMap(rawTask);
              return DailyTaskView(
                task: task,
                parentContext: context,
                mode: 'edit',
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
              widget.updateLastAccessDay(),
              widget.handleYesterdayDailies()
            ]).whenComplete(() {
                Navigator.pop(context);
              });
          } // Close the dialog
        )
      ],
    );
  }
}