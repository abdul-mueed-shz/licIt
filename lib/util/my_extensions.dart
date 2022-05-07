import 'package:flutter/material.dart';
import 'package:fyp/widget/text_widgets.dart';

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
}
