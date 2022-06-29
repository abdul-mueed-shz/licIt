import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/edit_profile/components/edit_profile_picture.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/widget/button.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/ProfileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? userCnic = PrefStorage.instance.id;
  LocalUser? localUser;
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () => loadInfo());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = localUser?.name ?? 'abdullah';
    cnicController.text = localUser?.cnicNo ?? '124567892656';
    emailController.text = localUser?.email ?? 'e@gmail.com';
    phoneController.text = localUser?.phoneNumber ?? '0345623452';

    final sized = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 1.5),
          )),
      body: SizedBox(
        width: sized.width,
        height: sized.height * .84,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(height: sized.height / 15),
          Center(
              child: EditProfilePicture(
                  imagePath: localUser?.signatureImage, onChanged: (value) {})),
          SizedBox(height: sized.height / 30),
          Text(localUser?.name ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5)),
          SizedBox(height: sized.height / 20),
          Container(
              width: sized.width,
              height: sized.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Column(children: [
                EditTextField(controller: nameController),
                EditTextField(controller: cnicController),
                EditTextField(controller: emailController),
                EditTextField(controller: phoneController),
                SizedBox(height: sized.height / 15),
                MyElevatedButton('Update', onTap: onTap)
              ])),
        ]),
      ),
    );
  }

  void onTap(BuildContext context) async {
    final update = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'cnicNo': cnicController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
    };
    await userRepository.update(userCnic ?? '1234567891011', update);
    loadInfo();
  }

  void loadInfo() async {
    localUser = await userRepository.get(userCnic ?? '1234567891011');
    setState(() {});
  }
}

class EditTextField extends StatelessWidget {
  final TextEditingController controller;
  const EditTextField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter text',
      ),
    );
  }
}
