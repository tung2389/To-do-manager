import 'package:flutter/material.dart';
import './view/widgets/Drawer/drawer.dart';
import './view/widgets/Task/task.dart';
import './model/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do manager",
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-do manager'),
        ),
        drawer: NavDrawer(),
        body: Container(
          child: TaskView(
            task: Task(
              id: '1234',
              name: 'Do your homework',
              importance: 'medium',
              description: 'Do your Math homework',
              startTime: '',
              endTime: '',
              createdAt: ''
            )
          )
        ),
      ),
    );
  }
}

