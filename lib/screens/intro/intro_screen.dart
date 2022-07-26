import 'package:flutter/material.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = "/IntroScreen";

  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void _onIntroEnd(context) {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  static Widget _buildImage(String assetName, [double width = 350]) =>
      Image.asset('assets/$assetName', width: width, height: 320);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          _buildPageViewModel(
              'LICIT',
              'Agreement',
              'An e-contract can also be in the form of a "click to agree" contract',
              'splash.jpg'),
          _buildPageViewModel(
              'LICIT',
              'Agreement',
              'Some of these e-signing methods are more secure than others.',
              'introSplash2.jpg'),
          _buildPageViewModel(
              'You Can Use',
              'App As',
              'They use digital identification to authenticate the signer. The signature is then electronically bound to the document using encryption',
              'introSplash3.jpg'),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  static PageViewModel _buildPageViewModel(
      String title, String subtitle, String description, String imageName) {
    const pageDecoration = PageDecoration(
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return PageViewModel(
      titleWidget: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: title,
              style: GoogleFonts.spartan(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Colors.blue,
              ),
              children: [
                TextSpan(
                  text: '\n$subtitle',
                  style: GoogleFonts.spartan(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                )
              ])),
      body: description,
      image: _buildImage(imageName),
      decoration: pageDecoration,
    );
  }
}
