import 'package:flutter/material.dart';
import '../../view/widgets/Drawer/drawer.dart';
import '../../view/widgets/Task/task.dart';
import '../../view/widgets/TaskCreator/creator.dart';
import '../../model/task.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog( 
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CreatorDialog();
          }
        ),
        child: const Icon(Icons.add)
      ),
    );
  }
}