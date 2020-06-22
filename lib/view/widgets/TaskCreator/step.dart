import 'package:flutter/material.dart';
import '../../../model/step.dart';

class StepView extends StatefulWidget {
  final TaskStep step;
  StepView({this.step, Key key}) : super(key: key);

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
             onChanged: (bool test) => {},
           ),
           Text('${widget.step.title}')
         ],
       ),
    );
  }
}