import 'package:flutter/material.dart';
import './Editor/editor.dart';
import '../loadingIndicator/loadingIndicator.dart';
import '../snackBar/error.dart';
import '../snackBar/success.dart';
import '../../../controller/todo.dart';
import '../../../model/task.dart';

class TaskView extends StatefulWidget {
  final Task task;
  final BuildContext parentContext;
  TaskView({this.task, this.parentContext}) : super(key: Key(task.id));

  @override 
  // Pass task property from StatefulWidget to the State widget
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool _loading = false;
  final TaskService _taskService = new TaskService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Editor(
            task: widget.task,
          );
        }
      ),
      child: Card(
        child: Row(
          children: <Widget>[
            _loading ?
            Loading() :
            Checkbox(
              value: widget.task.status== 'completed' ? true : false, 
              onChanged: 
                widget.task.status == 'completed' 
                ? null :
                (bool value) async {
                setState(() {
                  _loading = true;
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