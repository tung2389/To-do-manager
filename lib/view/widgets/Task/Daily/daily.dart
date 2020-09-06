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
  final BuildContext parentContext;
  final String mode;
  DailyTaskView({this.task, this.parentContext, this.mode}) : super(key: Key(task.id));

  @override 
  // Pass task property from StatefulWidget to the State widget
  _DailyTaskViewState createState() => _DailyTaskViewState();
}

class _DailyTaskViewState extends State<DailyTaskView> {
  bool _loading = false;

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
              value: widget.task.status== 'completed' ? true : false, 
              onChanged: 
                widget.mode == 'view' || widget.mode == 'viewOverdue'
                ? null :
                (bool value) async {
                setState(() {
                  _loading = true;
                });
                dynamic result = await DailyService.markAsCompleted(widget.task.id);
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
                if(widget.mode == 'view') {
                  return DailyService.delete(widget.task.id);
                }
                else{
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