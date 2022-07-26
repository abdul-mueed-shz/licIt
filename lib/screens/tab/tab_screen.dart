import 'package:flutter/material.dart';
import 'package:fyp/model/contract_create_model.dart';
import 'package:fyp/screens/agreement_screen/agreemenet_screen.dart';
import 'package:fyp/screens/contract_screen/contract_screen.dart';
import 'package:fyp/screens/edit_profile/edit_profile_screen.dart';
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
    const ProfileScreen(),
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
          backgroundColor: Colors.green,
          child: const Icon(Icons.add_circle_outlined),
          onPressed: () => _onTapFloatingActionButton(context)),
      bottomNavigationBar: NotchedBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _onTapFloatingActionButton(BuildContext context) => showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => bottomSheet());
      // Navigator.pushNamed(context, ContractScreen.routeName);
  Widget bottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, scrollController) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                  shrinkWrap: true,
                  itemCount: ContractCreateModel.contract.length,
                  itemBuilder: (context, index) {
                    final contract = ContractCreateModel.contract[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AgreementScreen.routeName,
                            arguments: contract);
                      },
                      child: SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: CustomCard(
                            title: contract.name,
                            description: contract.description,
                            iconData: contract.iconUrl,
                            time: contract.time),
                      ),
                    );
                  }),
            )
          ]),
        ),
        floatingActionButton: Container(
          transform:
          Matrix4.translationValues(0.0, -45, 0.0), // translate up by 30
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
            },
            child: const Icon(
              Icons.drag_handle,color: Colors.green,
              size: 50,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      ),
    );
  }

}
