import 'package:flutter/material.dart';
import 'package:fyp/util/my_slide_transition.dart';
import 'package:fyp/widget/gernal_text.dart';

class RadioListWidget extends StatefulWidget {
  final ValueChanged<String?> selectedRadioValue;
  final List<String> radioList;
  final String? value;
  final int delay;
  final String title;

  const RadioListWidget(
      {required this.selectedRadioValue,
      required this.title,
      required this.delay,
      this.value,
      required this.radioList,
      Key? key})
      : super(key: key);

  @override
  _RadioListWidgetState createState() => _RadioListWidgetState();
}

class _RadioListWidgetState extends State<RadioListWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MySlideTransition(
      delay: widget.delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralText(
              title: widget.title, fontWeight: FontWeight.bold, size: 16),
          Column(
              children: widget.radioList.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  activeColor: Colors.green,
                  value: e,
                  groupValue: selectedValue ?? widget.value,
                  onChanged: _onChanged,
                ),
                Expanded(child: Text(e)),
              ],
            );
          }).toList()),
        ],
      ),
    );
  }

  void _onChanged(String? value) {
    setState(() => selectedValue = value);
    widget.selectedRadioValue(value);
  }
}

class CheckBoxWidget extends StatefulWidget {
  final ValueChanged<bool?> selectedCheckedValue;
  final int delay;
  final String title;

  const CheckBoxWidget(
      {required this.selectedCheckedValue,
      required this.title,
      required this.delay,
      Key? key})
      : super(key: key);

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MySlideTransition(
      delay: widget.delay,
      child: CheckboxListTile(
        activeColor: Colors.green,
        title: Text(widget.title),
        value: _isChecked,
        onChanged: (newValue) {
          setState(() {
            _isChecked = newValue!;
            widget.selectedCheckedValue(newValue);
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }
}
