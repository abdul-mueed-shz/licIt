import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/util/my_extensions.dart';
import 'package:fyp/util/my_slide_transition.dart';

class DateTimeField extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  final int delay;
  final DateTime? defaultValue;
  final String title;

  const DateTimeField(
      {required this.onDateTimeChanged,
      required this.title,
      this.defaultValue,
      required this.delay,
      Key? key})
      : super(key: key);

  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    selectedDate = selectedDate ?? widget.defaultValue ?? DateTime.now();
    return MySlideTransition(
      delay: widget.delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralText(
              title: widget.title,
              size: 16,
              fontWeight: FontWeight.bold,
              align: TextAlign.left),
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
                onPressed: () => onPressPickDate(context),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                icon: const Icon(Icons.calendar_today),
                label: selectedDate.toString().formattedDate.toText()),
          ),
        ],
      ),
    );
  }

  void onPressPickDate(BuildContext context) async {
    final picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime: DateTime.now(),
        minTime: DateTime.now().dateOnly,
        maxTime: DateTime.now().add(const Duration(days: 1825)));
    if (picked != null && picked != selectedDate?.dateOnly) {
      setState(() {
        selectedDate = selectedDate?.applyDate(picked);
        widget.onDateTimeChanged(selectedDate!);
      });
    }
  }
}
