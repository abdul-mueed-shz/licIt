import 'package:flutter/material.dart';

class HideKeyboardOnBackgroundTap extends StatelessWidget {
  final Widget child;
  const HideKeyboardOnBackgroundTap({required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(context) => GestureDetector(
      child: child, onTap: () => FocusManager.instance.primaryFocus?.unfocus());
}
