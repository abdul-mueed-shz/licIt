import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/forgot_password/component/update_password_dialog.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final cnicController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cnicController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  "Please Enter Cnic To Reset the Password",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                    controller: cnicController,
                    title: 'Enter Cnic',
                    inputType: TextInputType.number,
                    validator: Validator.validateCnic),
                const SizedBox(height: 50),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: _onTapNext,
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNext() async {
    if (checkFields()) {
      var cnic = cnicController.text.trim();
      final localUser = await userRepository.get(cnic);
      if (localUser == null) {
        return EasyLoading.showError("No user found");
      }

      await updatePasswordDialog(context, cnic, _passwordController);
      cnicController.clear();
      _passwordController.clear();
      EasyLoading.showSuccess("You have logged in");
      Navigator.pop(context);
    }
  }
}
