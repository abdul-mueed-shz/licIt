import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/model/my_response_model.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/signup_screen/signature_board.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/hide_keyboard_on_background_tap.dart';
import 'package:fyp/widget/validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  CameraController? controller;
  Color greenColor = const Color(0xFF00AF19);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cnicNoController = TextEditingController();
  final phoneNumberController = TextEditingController();
  File? cnicImageFile, signatureImageFile, frontPic;
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

  Future<File?> frontFaceCamera(context) async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
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
            const SizedBox(height: 5.0),
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
            frontPic == null
                ? MyElevatedButton('Face Picture', onTap: (_) async {
                    final file = await frontFaceCamera(context);
                    frontPic = file;
                    setState(() {});
                  })
                : Container(
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          image: FileImage(frontPic!)),
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
    if (checkFields() &&
        signatureImageFile != null &&
        cnicImageFile != null &&
        frontPic != null) {
      EasyLoading.show();
      Fluttertoast.showToast(
          msg: "Please Wait We create the user ", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 1 // duration
          );
      final statusCode = await callApi(cnicImageFile!, frontPic!);
      if (statusCode?.code != 200) {
        setState(() {
          isLoading = false;
          frontPic == null;
        });
        return EasyLoading.showError(
            statusCode?.message ?? 'Some Thing Happen');
      } else if (statusCode?.code == 200 && statusCode?.message == 'success') {
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

  static Future<MyApiResponse?> callApi(File cnic, File face) async {
    // open a bytestream

    MyApiResponse? myResponse;
    final cnicStream = http.ByteStream(DelegatingStream.typed(cnic.openRead()));
    // get file length
    final cnicLength = await cnic.length();

    // multipart that takes file
    final cnicFile = http.MultipartFile('images', cnicStream, cnicLength,
        filename: path.basename(cnic.path));

    // open a bytestream
    final faceStream = http.ByteStream(DelegatingStream.typed(face.openRead()));
    // get file length
    final faceLength = await face.length();

    // multipart that takes file
    final faceFile = http.MultipartFile('images', faceStream, faceLength,
        filename: path.basename(face.path));

    // string to uri
    final uri = Uri.parse("https://licit-fyp.herokuapp.com/cnic/photo");

    // create multipart request
    final request = http.MultipartRequest("POST", uri);

    // add file to multipart
    request.files.add(cnicFile);
    request.files.add(faceFile);

    // send
    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return MyApiResponse(message: 'success', code: res.statusCode);
    } else if (response.statusCode == 400) {
      final result = jsonDecode(res.body);
      myResponse = MyApiResponse.fromJson(result);
      return myResponse;
    }

    return myResponse;
  }
}
