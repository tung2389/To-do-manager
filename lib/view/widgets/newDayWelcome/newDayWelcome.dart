import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../loadingIndicator/loadingIndicator.dart';

import '../../../controller/user.dart';
import '../../../controller/daily.dart';


class NewDayWelcome extends StatefulWidget {
  final List<DocumentSnapshot> dailyTaskList;
  final List<String> dailyTaskStatus;
  NewDayWelcome({this.dailyTaskList, this.dailyTaskStatus});

  @override
  _NewDayWelcomeState createState() => _NewDayWelcomeState();
}

class _NewDayWelcomeState extends State<NewDayWelcome> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //title: Text('Check off any dailies you completed yesterday'),
      contentPadding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20)
        )
      ),
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80
              ),
              Text(
                "Great! You have completed all daillies yesterday",
                style: TextStyle(
                  fontSize: 15
                ),
              )
            ],
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