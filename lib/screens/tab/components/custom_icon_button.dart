import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final bool isActive;
  final IconData iconData;
  final VoidCallback onTap;

  const CustomIconButton({
    required this.isActive,
    required this.iconData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(iconData ,color:isActive ? Colors.green : Colors.black, size: 30,),
      onPressed: onTap,
    );
  }
}
