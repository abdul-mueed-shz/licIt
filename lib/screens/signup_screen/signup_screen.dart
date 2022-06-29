import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/screens/signup_screen/signature_board.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/hide_keyboard_on_background_tap.dart';
import 'package:fyp/widget/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  Color greenColor = const Color(0xFF00AF19);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cnicNoController = TextEditingController();
  final phoneNumberController = TextEditingController();
  File? cnicImageFile, signatureImageFile;
  bool isLoading = false;

  Future<String?> upLoadImage(String userId, File image,
      {String type = 'image'}) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(
          'images/users/$userId/$type/$type${getFileExtension(image.path)}');
      await reference.putFile(image);
      print(reference);
      final downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      EasyLoading.showError('$error');
      return null;
    }
  }

  String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }

  Widget _identityCardWidget() {
    if (cnicImageFile != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              image: FileImage(cnicImageFile!)),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.credit_card),
          Text('Insert CNIC Card Picture'),
        ],
      );
    }
  }

  Widget _signatureWidget() {
    if (signatureImageFile != null) {
      return Container(
        alignment: Alignment.topCenter,
        child: const Text('Signature Board'),
        decoration: BoxDecoration(
          image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              image: FileImage(signatureImageFile!)),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //custom widget
          TextWithIconsButtons(
              iconData: Icons.edit,
              title: "Signature",
              onTap: (context) async {
                final image = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignatureBoard()));
                setState(() {
                  signatureImageFile = image;
                });
              }),

          const Text('Or'),

          TextWithIconsButtons(
              iconData: Icons.upload_file,
              title: "UpLoad",
              onTap: (context) async {
                final sign = await pickImage(context);
                setState(() {
                  signatureImageFile = sign;
                });
              }),
        ],
      );
    }
  }

  // pick image from your device
  Future<File?> pickImage(context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      print('NO IMAGE Selected');
      return null;
    }
  }

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
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cnicNoController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _buildSignUpForm(),
      ),
    );
  }

  _buildSignUpForm() {
    return HideKeyboardOnBackgroundTap(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Stack(
                children: [
                  const Positioned(
                    left: 120,
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
            const Text(
              'Sign Up',
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
                controller: nameController,
                title: 'Name',
                validator: Validator.validateName,
                inputType: TextInputType.text),
            CustomTextField(
                controller: cnicNoController,
                title: 'Cnic',
                validator: Validator.validateCnic,
                inputType: TextInputType.number),
            CustomTextField(
                controller: phoneNumberController,
                title: 'Phone Number',
                validator: Validator.validatePhoneNumber,
                inputType: TextInputType.number),
            CustomTextField(
                controller: emailController,
                title: 'Email',
                validator: Validator.validateEmail,
                inputType: TextInputType.emailAddress),
            CustomTextField(
                controller: passwordController,
                title: 'Password',
                validator: Validator.validatePassword,
                password: true),
            const SizedBox(
              height: 5.0,
            ),
            GestureDetector(
              onTap: () async {
                final cnicImage = await pickImage(context);
                setState(() {
                  cnicImageFile = cnicImage;
                });
              },
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                ),
                child: _identityCardWidget(),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 100,
              height: 150,
              child: _signatureWidget(),
            ),
            const SizedBox(
              height: 25.0,
            ),
            //FOR SignUp
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isLoading ? Colors.grey : greenColor,
                  fixedSize: const Size(200, 50),
                  shape: const CircleBorder()),
              onPressed: isLoading ? null : _onRegistered,
              child: const Icon(
                Icons.arrow_forward,
              ),
            ),

            const SizedBox(
              height: 25.0,
            ),
            MyElevatedButton('Back',
                onTap: isLoading ? (_) {} : _backPressed,
                width: 120,
                color: isLoading ? Colors.grey : greenColor,
                height: 37),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  void _backPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRegistered() async {
    setState(() {
      isLoading = true;
    });
    if (checkFields() && signatureImageFile != null && cnicImageFile != null) {
      EasyLoading.show();
      Fluttertoast.showToast(
          msg: "Please Wait We create the user ", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 1 // duration
          );
      final checkValidation =
          await userRepository.checkExist(cnicNoController.text);
      if (checkValidation == 'User Exist') {
        EasyLoading.dismiss();
        setState(() {
          isLoading = false;
        });
        EasyLoading.showError("User is Already exist");

        return;
      } else if (checkValidation == 'no user Found') {
        final token = await context
            .read<PromiseProvider>()
            .getDeviceTokenToSendNotification();

        String passwordHashing =
            Crypt.sha256(passwordController.text).toString();
        print("my hash password is $passwordHashing");
        final sign = await upLoadImage(
            cnicNoController.text.trim(),
            signatureImageFile ??
                File(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                ),
            type: 'signature');
        final cnic = await upLoadImage(
            cnicNoController.text.trim(),
            cnicImageFile ??
                File(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                ),
            type: 'cnic');
        final localUser = LocalUser(
            name: nameController.text,
            cnicNo: cnicNoController.text,
            phoneNumber: phoneNumberController.text,
            email: emailController.text,
            password: passwordHashing,
            cnicImageUrl: cnic,
            signatureImage: sign,
            token: token);
        await userRepository.add(localUser).then((value) {
          nameController.clear();
          cnicNoController.clear();
          phoneNumberController.clear();
          emailController.clear();
          passwordController.clear();
          cnicImageFile = null;
          signatureImageFile = null;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
          return EasyLoading.showSuccess("User  Created Successfully");
        }).catchError(
          (error) {
            EasyLoading.dismiss();
            setState(() {
              isLoading = false;
            });
            return EasyLoading.showError(error);
          },
        );
      } else {
        setState(() {
          isLoading = false;
        });
        return EasyLoading.showError(checkValidation);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      return EasyLoading.showError("Please Fill all the Field");
    }
  }
}
