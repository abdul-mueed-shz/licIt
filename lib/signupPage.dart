// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fyp/services/authservice.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  Color greenColor = const Color(0xFF00AF19);

  String? email, password, name, cnic, phoneNumber;

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validateCnic(String value) {
    //TO DO

    // String pattern = r'';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value)) {
    //   return 'Enter Valid Cnic';
    // } else {
    //   return null;
    // }
    return null;
  }

  String? validatePhoneNumber(String value) {
    //TO DO

    // String pattern = r'';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value)) {
    //   return 'Enter Valid Cnic';
    // } else {
    //   return null;
    // }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: _buildSignUpForm(),
        ),
      ),
    );
  }

  _buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: 200,
            child: Stack(
              children: [
                // ignore: prefer_const_constructors
                Positioned(
                  left: 120,
                  child: const Text(
                    'LicIt',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,

                      //fontFamily:,
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 240.0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greenColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // ignore: prefer_const_constructors
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 40,
                //fontWeight: FontWeight.bold,
                //fontFamily:,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(
                //fontFamily: ,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
            ),
            onChanged: (value) {
              name = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Name can\'t be empty' : null,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Cnic',
              labelStyle: TextStyle(
                //fontFamily: ,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
            ),
            onChanged: (value) {
              cnic = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Cnic can\'t be empty' : validateCnic(value),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(
                //fontFamily: ,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
            ),
            onChanged: (value) {
              phoneNumber = value;
            },
            validator: (value) => value!.isEmpty
                ? 'Phone Number can\'t be empty'
                : validateCnic(value),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'EMAIL',
              labelStyle: TextStyle(
                //fontFamily: ,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
            ),
            onChanged: (value) {
              email = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Email can\'t be empty' : validateEmail(value),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(
                //fontFamily: ,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenColor),
              ),
            ),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Password can\'t be empty' : null,
          ),
          SizedBox(
            height: 5.0,
          ),

          SizedBox(
            height: 25.0,
          ),
          //FOR SignUp
          FloatingActionButton(
            backgroundColor: greenColor,
            onPressed: () {
              if (checkFields()) {
                AuthService().SignUp(email!, password!, context);
              }
            },
            child: Icon(
              Icons.arrow_forward,
            ),
          ),

          SizedBox(
            height: 25.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 56.0,
                    width: 120,
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text('Go Back',
                          style: TextStyle(
                            color: Colors.white,
                            //fontFamily: ,
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
