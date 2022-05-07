import 'package:flutter/material.dart';
import 'package:fyp/screens/forgot_password/forgot_password.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/signup_screen/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
};
