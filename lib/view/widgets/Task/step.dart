import 'package:flutter/material.dart';
import 'package:to_do_manager/model/step.dart';

class StepView extends StatefulWidget {
  final TaskStep step;
  final void Function(bool value) updateStep;
  StepView({this.step, this.updateStep, Key key}) : super(key: key);

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         children: <Widget>[
           Checkbox(
             value: widget.step.completed,
             onChanged: (bool value) => widget.updateStep(value),
           ),
           Text('${widget.step.title}')
         ],
       ),
    );
  }
}