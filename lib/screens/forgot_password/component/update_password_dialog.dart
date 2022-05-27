import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/util/my_extensions.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';

Future<void> updatePasswordDialog(BuildContext context, String cnic,
    TextEditingController passwordController) {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            'Alert Password Change'.toText(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            CustomTextField(
                controller: passwordController,
                title: 'Enter password',
                password: true,
                validator: Validator.validatePassword),
            const SizedBox(height: 40),
            MyElevatedButton('Reset Password',
                width: 200,
                height: 35,
                onTap: (context) => _onTap(context, passwordController, cnic))
          ],
        ),
      ),
    ),
  );
}

void _onTap(BuildContext context, TextEditingController passwordController,
    String cnic) async {
  EasyLoading.show();
  String passwordHashing =
      Crypt.sha256(passwordController.text.trim()).toString();
  final body = {
    'password': passwordHashing,
  };
  await userRepository.update(cnic, body);
  EasyLoading.dismiss();
  EasyLoading.showSuccess("Successfully Update");
  Navigator.pop(context);
  passwordController.clear();
}
