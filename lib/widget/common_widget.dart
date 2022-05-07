import 'package:flutter/material.dart';
import 'package:fyp/util/constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType inputType;
  final bool password;
  final Color color;
  final String? Function(String?) validator;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      this.password = false,
      this.color = Colors.green,
      this.inputType = TextInputType.text,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: password,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          //fontFamily: ,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.withOpacity(0.7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }

//upload image on firebase storage
}

class TextWithIconsButtons extends StatelessWidget {
  final String title;
  final IconData iconData;
  final BuildContextCallback onTap;

  const TextWithIconsButtons(
      {required this.iconData,
      required this.title,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title),
            Icon(iconData),
          ],
        ),
      ),
    );
  }
}
