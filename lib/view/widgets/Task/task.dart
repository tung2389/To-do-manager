import 'package:flutter/material.dart';
import '../loadingIndicator/loadingIndicator.dart';
import '../snackBar/error.dart';
import '../snackBar/success.dart';
import '../../../controller/task.dart';

class TaskView extends StatefulWidget {
  final Map<String, dynamic> task;
  final BuildContext parentContext;
  TaskView({this.task, this.parentContext}) : super(key: Key(task['id']));
  // TaskView({this.task}) : super(key: task);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool checked = false;
  bool loading = false;
  final TaskService _taskService = new TaskService();

  void _showContent(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('${widget.task['name']}'),
          children: <Widget>[
            Text('${widget.task['description']}'),
            Text('${widget.task['importance']}')
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showContent(context),
      child: Card(
        child: Row(
          children: <Widget>[
            loading ?
            Loading() :
            Checkbox(
              value:checked, 
              onChanged: (bool value) async {
                setState(() {
                  loading = true;
                });
                dynamic result = await _taskService.markAsCompleted(widget.task['id']);
                                            //  .whenComplete(() {
                                            //     setState(() {
                                            //       checked = value;
                                            //       loading = false;
                                            //     });                                              
                                            //  });
                if(result == null) {
                  Scaffold.of(widget.parentContext).showSnackBar( // We cannot use of(context) here because the task will be dispose when completed, so the context is not available
                    ErrorSnackBar(
                      message: 'There is an error while updating your task',
                    ).build()
                  );
                }
                else {
                  Scaffold.of(widget.parentContext).showSnackBar(
                    SuccessSnackBar(
                      message: 'Congratulation! You have completed a task',
                    ).build()
                  );
                }
              },
              // activeColor: ,
            ),
            Text(
              '${widget.task['name']}'
            ),  
          ],
        )
      )
    );
  }
}