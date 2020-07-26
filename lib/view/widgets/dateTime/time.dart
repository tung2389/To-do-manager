import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BasicTimeField extends StatelessWidget {
  final TimeOfDay initialValue;
  final format = DateFormat("HH:mm");
  final void Function(dynamic value) onChanged;
  final bool enabled;
  BasicTimeField({this.initialValue, this.onChanged, this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        enabled: enabled,
        format: format,
        //initialValue: DateTimeField.convert(initialValue),
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          onChanged(time);
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}