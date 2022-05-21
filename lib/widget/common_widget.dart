import 'package:flutter/material.dart';
import 'package:fyp/util/constant.dart';
import 'package:google_fonts/google_fonts.dart';

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

class TitleWithTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String title;
  final TextInputType inputType;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final String? Function(String?)? validator;
  const TitleWithTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.text,
      this.size = 20,
      this.color = Colors.green,
      this.fontWeight = FontWeight.bold,
      this.inputType = TextInputType.text,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: GoogleFonts.lato(fontWeight: fontWeight, fontSize: size)),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: inputType,
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
        ),
      ],
    );
  }
}
