import 'package:flutter/material.dart';
import 'package:fyp/screens/tab/components/custom_icon_button.dart';

class NotchedBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  const NotchedBottomNavigationBar({
    required this.onItemTapped,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomIconButton(
            iconData: Icons.home,
            isActive: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          const SizedBox(width: 100),
          CustomIconButton(
            iconData: Icons.notifications,
            onTap: () => onItemTapped(2),
            isActive: selectedIndex == 2,
          ),
          CustomIconButton(
            iconData: Icons.person,
            onTap: () => onItemTapped(1),
            isActive: selectedIndex == 1,
          ),
        ],
      ),
    );
  }
}
