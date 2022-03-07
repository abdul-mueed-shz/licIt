import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/services/errorHandler.dart';
import 'package:fyp/services/settingDefaultDatabaseStuff.dart';
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
  // ignore: non_constant_identifier_names
  SignUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String cnic,
    required context,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      SettingDefaultStuff().setUser(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          cnic: cnic,
          id: value.user!.uid);
      Navigator.of(context).pop();
    }).catchError((e) => ErrorHandler().errorDialogue(context, e));
  }

  //Get Current Users ID
  String getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
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
