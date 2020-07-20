import 'package:flutter/material.dart';
import './Editor/editor.dart';
import './ViewOnly/view.dart';
import '../loadingIndicator/loadingIndicator.dart';
import '../snackBar/error.dart';
import '../snackBar/success.dart';
import '../../../controller/todo.dart';
import '../../../model/todo.dart';

class TaskView extends StatefulWidget {
  final TodoTask task;
  final BuildContext parentContext;
  final String mode;
  TaskView({this.task, this.parentContext, this.mode}) : super(key: Key(task.id));

  @override 
  // Pass task property from StatefulWidget to the State widget
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool _loading = false;
  final TodoService _todoService = new TodoService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if(widget.mode == 'edit') {
            return Editor(
              task: widget.task,
            );
          }
          else {
            return ViewOnly(
              task: widget.task
            );
          }
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
                dynamic result = await _todoService.markAsCompleted(widget.task.id);
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