import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/screens/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _initializeEveryThing();
  }

  _initializeEveryThing() async {
    Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, IntroScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 350,
          child: Image(
            image: AssetImage('assets/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
