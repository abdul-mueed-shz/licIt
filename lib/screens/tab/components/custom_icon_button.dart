import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final bool isActive;
  final String name;
  final VoidCallback onTap;

  const CustomIconButton({
    required this.isActive,
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/icons/$name${isActive ? '_active' : ''}_icon.png',
        height: 25,
      ),
      onPressed: onTap,
    );
  }
}
