import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BasicDateTimeField extends StatelessWidget {
  final DateTime initialValue;
  final void Function(dynamic value) onChanged;
  final bool enabled;
  BasicDateTimeField({this.initialValue, this.onChanged, this.enabled = true});

  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        enabled: enabled,
        format: format,
        initialValue: initialValue,
        validator: (val) => val == null ? "Field is required" : null,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );

            onChanged(DateTimeField.combine(date, time));
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}