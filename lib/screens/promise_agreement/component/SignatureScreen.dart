import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/screens/signup_screen/signature_board.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:fyp/widget/button.dart';

class SignatureScreen extends StatefulWidget {
  static const String routeName = '/SignatureScreen';
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  LocalUser? localUser;
  String? userCnic = PrefStorage.instance.id;
  File? signatureImageFile;

  @override
  void didChangeDependencies() {
    Timer(const Duration(seconds: 1), () => loadInfo());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () => loadInfo());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Signature'),
            centerTitle: true,
            backgroundColor: Colors.green),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Spacer(),
          signatureWidget(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: DeleteBacKFunctionality(
                    iconData: Icons.keyboard_backspace, onTap: _back),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: MyElevatedButton('Next Button', onTap: _tap),
              ),
            ],
          ),
        ]));
  }

  Widget signatureWidget() {
    if (signatureImageFile != null) {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Text('Signature',
              style: TextStyle(color: Colors.green.withOpacity(0.3))),
          decoration: BoxDecoration(
            image: DecorationImage(
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
                image: FileImage(signatureImageFile!)),
          ),
        ),
      );
    } else {
      return Column(children: [
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.autorenew),
              SizedBox(width: 10),
              Text('Clear'),
            ],
          ),
          onTap: onTap,
        ),
        const SizedBox(height: 20),
        isSignatureWrite(),
      ]);
    }
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _tap(BuildContext context) async {
    print(localUser?.cnicNo);
    if (signatureImageFile != null) {
      await upLoadImage(
          localUser?.cnicNo.toString() ?? '',
          signatureImageFile ??
              File(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              ),
          type: 'signature');
      Navigator.pushNamed(context, WarningScreen.routeName);
    } else {
      Navigator.pushNamed(context, WarningScreen.routeName);
    }
  }

  Widget isSignatureWrite() {
    String image = localUser?.signatureImage ?? '';

    if (localUser?.signatureImage != null) {
      return Container(
          alignment: Alignment.center,
          child: Image.network(image, fit: BoxFit.cover));
    } else {
      return const Text('not text found');
    }
  }

  Future<String?> upLoadImage(String userId, File image,
      {String type = 'image'}) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(
          'images/users/$userId/$type/$type${getFileExtension(image.path)}');
      await reference.putFile(image);
      print(reference);
      final downloadUrl = await reference.getDownloadURL();
      signatureImageFile = null;
      return downloadUrl;
    } catch (error) {
      EasyLoading.showError('$error');
      return null;
    }
  }

  String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }

  void loadInfo() async {
    localUser = await userRepository.get(userCnic ?? '1234567891041');
    setState(() {});
  }

  void onTap() async {
    final image = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SignatureBoard()));
    setState(() {
      signatureImageFile = image;
    });
  }
}
