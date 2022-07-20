import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralText extends StatelessWidget {
  final String title;
  final double size;
  final TextAlign? align;
  final FontWeight fontWeight;

  const GeneralText(
      {Key? key,
        this.fontWeight = FontWeight.normal,
        required this.title,
        this.size = 30,
        this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: GoogleFonts.lato(fontSize: size, fontWeight: fontWeight),
    );
  }
}