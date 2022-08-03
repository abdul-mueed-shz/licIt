import 'package:flutter/material.dart';
import 'package:fyp/screens/agreement_screen/agreemenet_screen.dart';
import 'package:fyp/screens/edit_profile/edit_profile_screen.dart';
import 'package:fyp/screens/forgot_password/forgot_password.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:fyp/screens/home_screen/home_screen.dart';
import 'package:fyp/screens/intro/intro_screen.dart';
import 'package:fyp/screens/job_agreement/job_agreement_preview_screen.dart';
import 'package:fyp/screens/job_agreement/job_agreement_screen.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/notification_review_back/notification_review_back.dart';
import 'package:fyp/screens/preview/preview_screen.dart';
import 'package:fyp/screens/rent_agreement/rent_agreement_preview_screen.dart';
import 'package:fyp/screens/rent_agreement/rent_agreement_screen.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:fyp/screens/signup_screen/signup_screen.dart';
import 'package:fyp/screens/splash/splash_screen.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';

import '../screens/contract_screen/contract_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  TabScreen.routeName: (context) => const TabScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  HomePage.routeName: (context) => const HomePage(),
  RentAgreementScreen.routeName: (context) => const RentAgreementScreen(),
  RentAgreementPreviewScreen.routeName: (context) =>
      const RentAgreementPreviewScreen(),
  ContractScreen.routeName: (context) => const ContractScreen(),
  AgreementScreen.routeName: (context) => const AgreementScreen(),
  GeneralTemplate.routeName: (context) => const GeneralTemplate(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  WarningScreen.routeName: (context) => const WarningScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  PreviewScreen.routeName: (context) => const PreviewScreen(),
  JobAgreementScreen.routeName: (context) => const JobAgreementScreen(),
  JobAgreementPreviewScreen.routeName: (context) =>
      const JobAgreementPreviewScreen(),
  NotificationScreenBack.routeName: (context) => const NotificationScreenBack()
};
