import 'package:flutter/material.dart';
import 'package:fyp/util/constant.dart';
import 'package:fyp/util/my_extensions.dart';

class MyElevatedButton extends StatelessWidget {
  final BuildContextCallback onTap;
  final String title;
  final Color color;
  final double? width;
  final double height;
  final Color titleColor;
  final EdgeInsetsGeometry margin;

  const MyElevatedButton(
    this.title, {
    Key? key,
    required this.onTap,
    this.titleColor = Colors.white,
    this.width = double.infinity,
    this.height = 48,
    this.color = Colors.green,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: title.toText(
              color: titleColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => onTap(context),
        ),
      ),
    );
  }
}

class DeleteBacKFunctionality extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final double height;
  final BuildContextCallback onTap;
  const DeleteBacKFunctionality(
      {Key? key,
        this.color = Colors.green,
        this.height = 50,
        required this.iconData,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        width: 150,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}