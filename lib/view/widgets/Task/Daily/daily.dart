import 'package:flutter/material.dart';
import 'Editor/editor.dart';
import 'ViewOnly/view.dart';
import '../../loadingIndicator/loadingIndicator.dart';
import '../../snackBar/error.dart';
import '../../snackBar/success.dart';
import '../../../../controller/daily.dart';
import '../../../../model/daily.dart';
import '../dropdownTaskOptions.dart';

class DailyTaskView extends StatefulWidget {
  final DailyTask task;
  final int taskIndex;
  final BuildContext parentContext;
  final String mode;
  final void Function(int index, String value) changeTaskStatus;
  DailyTaskView({
    this.task, 
    this.taskIndex, 
    this.parentContext, 
    this.mode, 
    this.changeTaskStatus
  }) : super(key: Key(task.id));

  @override 
  // Pass task property from StatefulWidget to the State widget
  _DailyTaskViewState createState() => _DailyTaskViewState(task.status);
}

class _DailyTaskViewState extends State<DailyTaskView> {
  bool _loading = false;
  String taskStatus;
  _DailyTaskViewState(status) {
    taskStatus = status;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if(widget.mode == 'edit') {
            return DailyEditor(
              task: widget.task,
            );
          }
          else {
            return DailyViewOnly(
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
              value: taskStatus == 'completed' ? true : false, 
              onChanged: (bool value) async {
                switch(widget.mode) {
                  case 'view': return null;
                  case 'viewOverdue': return null;

                  case 'checkOff': {
                    if(value == true) {
                      widget.changeTaskStatus(widget.taskIndex, 'completed');
                      setState(() {
                        taskStatus = 'completed';
                      });

                    }
                    else {
                      widget.changeTaskStatus(widget.taskIndex, 'pending');
                      setState(() {
                        taskStatus = 'pending';
                      });  
                    }
                  }
                  break;
                  
                  case 'edit': {
                    setState(() {
                        _loading = true;
                      });
                    DailyService.markAsCompleted(widget.task.id)
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
                  }
                  break;
                }
              }
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
              editor: DailyEditor(
                task: widget.task,
              ),
              viewOnly: DailyViewOnly(
                task: widget.task
              ),
              deleteTask: () {
                if(widget.mode == 'view' 
                  || widget.mode =='checkOff'
                  || widget.mode == 'edit'
                ) {
                  return DailyService.delete(widget.task.id);
                }
                else {
                  return DailyService.deleteOverdue(widget.task.id);
                }
              }
            )
          ],
        )
      )
    );
  }
}