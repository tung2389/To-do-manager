import 'package:flutter/material.dart';
import 'Editor/editor.dart';
import 'ViewOnly/view.dart';
import '../../loadingIndicator/loadingIndicator.dart';
import '../../snackBar/error.dart';
import '../../snackBar/success.dart';
import '../../../../controller/todo.dart';
import '../../../../model/todo.dart';
import '../dropdownTaskOptions.dart';

class TodoTaskView extends StatefulWidget {
  final TodoTask task;
  final BuildContext parentContext;
  final String mode;
  TodoTaskView({this.task, this.parentContext, this.mode}) : super(key: Key(task.id));

  @override 
  // Pass task property from StatefulWidget to the State widget
  _TodoTaskViewState createState() => _TodoTaskViewState();
}

class _TodoTaskViewState extends State<TodoTaskView> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if(widget.mode == 'edit') {
            return TodoEditor(
              task: widget.task,
            );
          }
          else {
            return TodoViewOnly(
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
                widget.mode == 'view' 
                ? null :
                (bool value) async {
                setState(() {
                  _loading = true;
                });
                TodoService.markAsCompleted(widget.task.id)
                  .then((value) {
                    Scaffold.of(widget.parentContext).showSnackBar(
                      SuccessSnackBar(
                        message: 'Congratulation! You have completed a task',
                      ).build()
                    );
                  })
                  .catchError((error) {
                    Scaffold.of(widget.parentContext).showSnackBar( // We cannot use of(context) here because the task will be dispose when completed, so the context is not available
                      ErrorSnackBar(
                        message: 'There is an error while updating your task',
                      ).build()
                    );
                    setState(() {
                      _loading = false;
                    });
                  });
              },
              // activeColor: ,
            ),
            Text(
              '${widget.task.title}'
            ),  
            Spacer(), // Fill the remaining space to put the button at the end of row
            DropdownTaskOptions(
              items: (
                widget.mode == 'edit' 
                ? ['Edit', 'Delete']
                : ['View', 'Delete']
              ),
              editor: TodoEditor(
                task: widget.task,
              ),
              viewOnly: TodoViewOnly(
                task: widget.task
              ),
            )
          ],
        )
      )
    );
  }
}