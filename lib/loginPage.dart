import 'package:flutter/material.dart';
import 'package:fyp/services/authservice.dart';
import 'package:fyp/signupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color greenColor = const Color(0xFF00AF19);

  final _formKey = GlobalKey<FormState>();

  String? email, password;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ListView(
        children: [
          const SizedBox(
            height: 75,
          ),
          Container(
            height: 150,
            width: 200,
            child: Stack(
              children: [
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
            child: Text(
              'Sign In',
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
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(
                top: 15.0,
                left: 20.0,
              ),
              child: InkWell(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: greenColor,
                      //fontFamily: ,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          //FOR LOGIN
          FloatingActionButton(
            backgroundColor: greenColor,
            onPressed: () {
              if (checkFields()) {
                AuthService().signIn(email!, password!, context);
              }
            },
            child: Icon(
              Icons.arrow_forward,
            ),
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     height: 60.0,
          //     child: Material(
          //       child: Center(
          //         child: Text(
          //           'LOGIN',
          //           style: TextStyle(
          //             color: Colors.white,
          //             //fontFamily: ,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //       shadowColor: Colors.greenAccent,
          //       elevation: 7.0,
          //       color: greenColor,
          //       borderRadius: BorderRadius.circular(
          //         20.0,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 25.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
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
                      child: Text('Sign Up',
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
