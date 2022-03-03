import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/services/errorHandler.dart';
import 'package:fyp/signupPage.dart';
import '../homePage.dart';
import '../loginPage.dart';

class AuthService {
  //check if user is authenticated
  handleAuthentiation() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }

//Sign Up
  SignUp(String email, String password, context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.of(context).pop())
        .catchError((e) => ErrorHandler().errorDialogue(context, e));
  }

  //Sign In
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => print('Logged In'))
        .catchError((e) => ErrorHandler().errorDialogue(context, e));
  }

  //Sign OUT
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
