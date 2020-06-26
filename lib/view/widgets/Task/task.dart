import 'package:flutter/material.dart';
import '../loadingIndicator/loadingIndicator.dart';
import '../snackBar/error.dart';
import '../snackBar/success.dart';
import '../../../controller/todo.dart';
import '../../../model/task.dart';

class TaskView extends StatefulWidget {
  Task task;
  final BuildContext parentContext;
  TaskView({this.task, this.parentContext}) : super(key: Key(task.id));
  // TaskView({this.task}) : super(key: task);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  // Task task = widget.task;
  bool loading = false;
  final TaskService _taskService = new TaskService();

  void _showContent(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: TextFormField(
            initialValue: widget.task.title,
            // '${widget.task['title']}',
            // style: TextStyle(
            //   fontSize: 18,
            //   color: Colors.white
            // ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal:10,
            vertical: 10
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20)
            )
          ),
          backgroundColor: Colors.blue[500],
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Description: '),
                      Text('${widget.task.description}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Priority: '),
                      Text('${widget.task.priority}')
                    ],
                  ),
                ],
              ),
            ) 
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
              value: widget.task.status== 'completed' ? true : false, 
              onChanged: 
                widget.task.status == 'completed' 
                ? null :
                (bool value) async {
                setState(() {
                  loading = true;
                });
                dynamic result = await _taskService.markAsCompleted(widget.task.id);
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
              '${widget.task.title}'
            ),  
          ],
        )
      )
    );
  }
}