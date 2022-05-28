import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/forgot_password/forgot_password.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/screens/signup_screen/signup_screen.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color greenColor = const Color(0xFF00AF19);

  final _formKey = GlobalKey<FormState>();

  final cnicController = TextEditingController();
  final passwordController = TextEditingController();

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    cnicController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _buildLoginForm(),
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
          SizedBox(
            height: 150,
            width: 200,
            child: Stack(
              children: [
                const Positioned(
                  left: 100,
                  child: Text(
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
                  left: 220.0,
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
          const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 40,
              //fontWeight: FontWeight.bold,
              //fontFamily:,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              controller: cnicController,
              title: 'Cnic',
              inputType: TextInputType.number,
              validator: Validator.validateCnic),
          CustomTextField(
              controller: passwordController,
              title: 'Password',
              validator: Validator.validatePassword,
              password: true),
          const SizedBox(
            height: 5.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: Container(
              alignment: const Alignment(1.0, 0.0),
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 20.0,
              ),
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
          const SizedBox(
            height: 25.0,
          ),
          //FOR LOGIN
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: greenColor,
              fixedSize: const Size(200, 40),
              shape: const CircleBorder(),
            ),
            onPressed: _onLogin,
            child: const Icon(
              Icons.arrow_forward,
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
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
                    child: const Center(
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

  void _onLogin() async {
    await storage.allClear();
    if (checkFields()) {
      EasyLoading.show();
      final checkValidation =
          await userRepository.checkExist(cnicController.text.trim());
      if (checkValidation == 'User Exist') {
        EasyLoading.dismiss();
        final localUser = await userRepository.get(cnicController.text.trim());
        if (localUser == null) {
          return EasyLoading.showError("No User Found");
        }
        final password = localUser.password;
        final cnic = localUser.cnicNo;
        final data = Crypt(password).match(passwordController.text.trim());

        if (cnic == cnicController.text.trim() && data) {
          await storage.setId(cnic);
          final token = await context
              .read<PromiseProvider>()
              .getDeviceTokenToSendNotification();
          final update = {
            'token': token,
          };
          await userRepository.update(cnic, update);
          Navigator.pushReplacementNamed(context, TabScreen.routeName);
          cnicController.clear();
          passwordController.clear();
        } else {
          EasyLoading.showError("Incorrect Data Entered");
        }
      } else if (checkValidation == 'no user Found') {
        EasyLoading.dismiss();
        EasyLoading.showError("no User Found");
        return;
      } else {
        return EasyLoading.showError(checkValidation);
      }
    }
  }
}
