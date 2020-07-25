import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  final void Function(dynamic value) onChanged;
  final bool enabled;
  BasicTimeField({this.onChanged, this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        enabled: enabled,
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          onChanged(DateTimeField.convert(time));
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}