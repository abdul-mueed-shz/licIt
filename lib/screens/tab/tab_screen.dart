import 'package:flutter/material.dart';
import 'package:fyp/contract_screen/contract_screen.dart';
import 'package:fyp/screens/home_screen/home_screen.dart';
import 'package:fyp/screens/notifcation_screen/notification_screen.dart';

import 'components/notched_bottom_navigation_bar.dart';

class TabScreen extends StatefulWidget {
  static const String routeName = '/TabScreen';

  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  final List<Widget> tabWidgets = [
    const HomePage(),
    const NotificationScreen(),
    const NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: tabWidgets,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add_circle_outlined),
          onPressed: () => _onTapFloatingActionButton(context)),
      bottomNavigationBar: NotchedBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _onTapFloatingActionButton(BuildContext context) =>
      Navigator.pushNamed(context, ContractScreen.routeName);
}
