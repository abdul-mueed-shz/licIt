// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fyp/services/authservice.dart';
import 'package:fyp/templateListDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color greenColor = const Color(0xFF00AF19);
  final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
      drawer: TemplateDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.logout,
                size: 35.0,
                color: greenColor,
              ),
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ),
        ],
        title: SizedBox(
          width: 120,
          child: Stack(
            children: [
              Text(
                'LicIt',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: 24.0,
                left: 60.0,
                child: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topBarWidget(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              child: Container(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(
                    'Contracts list',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Material(
        color: Colors.transparent,
        child: Ink(
          width: 120,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
          ), // LinearGradientBoxDecoration
          child: InkWell(
            onTap: () {
              _ScaffoldKey.currentState!.openDrawer();
              print('Opened');
            },
            customBorder: CircleBorder(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.add,
                    size: 55.0,
                    color: greenColor,
                  ),
                  Text(
                    'Choose',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Template',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            splashColor: Colors.blueGrey,
          ), // Red will correctly spread over gradient
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: bottomBarWidget(),
      ),
    );
  }
}

topBarWidget() {
  return Container(
    color: Colors.white,
    height: 50,
    child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'All',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: 1,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: 1,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Pending',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: 1,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Rejected',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ]),
  );
}

bottomBarWidget() {
  return Container(
    color: Colors.grey[300],
    height: 50,
    child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(10.0),
            onPressed: () {},
            child: Icon(
              Icons.notifications,
              size: 30.0,
            ),
          ),
          Container(
            color: Colors.black,
            width: 1,
          ),
          FlatButton(
            padding: EdgeInsets.all(10.0),
            onPressed: () {},
            child: Icon(
              Icons.home,
              size: 30.0,
            ),
          ),
          Container(
            color: Colors.black,
            width: 1,
          ),
          FlatButton(
            padding: EdgeInsets.all(10.0),
            onPressed: () {},
            child: Icon(
              Icons.settings,
              size: 30.0,
            ),
          )
        ]),
  );
}
