import 'package:flutter/material.dart';
import 'package:fyp/widget/text_widgets.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  MyText toText({
    bool upperCase = false,
    double? fontSize,
    TextStyle? style,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    Color? color,
    double letterSpacing = 0,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return MyText(
      this,
      fontSize: fontSize,
      style: style,
      upperCase: upperCase,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  String dateWithFormat(String format) =>
      DateFormat(format).format(DateTime.parse(this));
  String get formattedDate => DateFormat.yMMMd().format(DateTime.parse(this));
  String get formattedTime => DateFormat.jm().format(DateTime.parse(this));
}

extension DateTimeExtension on DateTime {
  DateTime applyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day, hour, minute);
  DateTime applyTime(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute);
  TimeOfDay get timeDay => TimeOfDay(hour: hour, minute: minute);
  DateTime get dateOnly => DateTime(year, month, day);
}
