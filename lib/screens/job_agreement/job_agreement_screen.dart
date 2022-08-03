import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/job_agreement/job_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobAgreementScreen extends StatefulWidget {
  static const String routeName = '/JobAgreementScreen';
  const JobAgreementScreen({Key? key}) : super(key: key);

  @override
  State<JobAgreementScreen> createState() => _JobAgreementScreenState();
}

class _JobAgreementScreenState extends State<JobAgreementScreen> {
  final formDataKey = GlobalKey<FormState>();

  @override
  void initState() {
    final pref = storage.contract;
    final provider = context.read<JobProvider>();
    if (pref?.jobAgreementTitle != null && pref?.jobAddress != null) {
      provider.updateJobField();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<JobProvider>();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(storage.id)
              .collection("contract")
              .doc(storage.contract?.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.data!.data();
              if (data != null) {
                final contractData = ContractModel.fromJson(data);
                storage.setContract(contractData);
              }
            }
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Form(
                      key: formDataKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                                "\t\t\t\t\tJob Offer\nEmployment Contract",
                                style: GoogleFonts.spartan(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    letterSpacing: 2)),
                          ),
                          const SizedBox(height: 60),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Private and confidential')),
                          const SizedBox(height: 20),
                          Align(
                              alignment: Alignment.topLeft,
                              child: FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  afterBlankText: '',
                                  hint: 'Abdul Moeed Shahbaz',
                                  blankSize: 20,
                                  controller: provider.jobUserName)),
                          Row(
                            children: [
                              FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: 'Street Number 54',
                                  afterBlankText: ',',
                                  blankSize: 18,
                                  controller: provider.jobAddress),
                              FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: 'Jaloo',
                                  afterBlankText: ',',
                                  blankSize: 10,
                                  controller: provider.jobName),
                            ],
                          ),
                          Row(
                            children: [
                              FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: 'Lahore',
                                  afterBlankText: ',',
                                  blankSize: 10,
                                  controller: provider.jobCity),
                              FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: 'Punjab',
                                  afterBlankText: ',',
                                  blankSize: 10,
                                  controller: provider.jobProvince),
                              FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: '55056',
                                  afterBlankText: ',',
                                  blankSize: 10,
                                  controller: provider.jobPostalCode),
                            ],
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: FormatFillInTheBlanks(
                                  beforeBlankText: '',
                                  hint: 'Pakistan',
                                  afterBlankText: ',',
                                  blankSize: 10,
                                  controller: provider.jobCountry)),
                          const SizedBox(height: 20),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Offer of Employment')),
                          const SizedBox(height: 20),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Dear,')),
                          const SizedBox(height: 20),
                          FormatFillInTheBlanks(
                              beforeBlankText:
                                  'With reference to your application for employment and the subsequent interview you had with us, we are pleased to offer you employment with ',
                              hint: 'LICIT',
                              afterBlankText:
                                  'on the following terms and conditions.',
                              blankSize: 7,
                              controller: provider.jobAgreementTitle),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Our Company is An FYP ka aidea \n',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.spartan(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 2)),
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'This offer is subject to the fulfillment of the pre-contractual conditions of you being found medically fit and verification done by the Company of the accuracy of testimonials and information provided by you.',
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DeleteBacKFunctionality(
                                    iconData: Icons
                                        .keyboard_double_arrow_left_outlined,
                                    onTap: _homeBack),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: DeleteBacKFunctionality(
                                    iconData: Icons.keyboard_backspace,
                                    onTap: _deleteTap),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                flex: 5,
                                child: MyElevatedButton('Next', onTap: _tap),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: DeleteBacKFunctionality(
                                    iconData: Icons.delete, onTap: _deleteTap),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  void _deleteTap(BuildContext context) {}

  void _tap(BuildContext context) async {
    final provider = context.read<JobProvider>();
    if (formDataKey.currentState!.validate()) {
      provider.updateGeneralTextField();
      Timer(const Duration(seconds: 2),
          () => Navigator.pushNamed(context, WarningScreen.routeName));
    }
  }

  void _homeBack(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(TabScreen.routeName));
  }
}

class FormatFillInTheBlanks extends StatefulWidget {
  final String beforeBlankText;
  final String afterBlankText;
  final int blankSize;
  final TextEditingController controller;
  final String hint;
  const FormatFillInTheBlanks(
      {required this.beforeBlankText,
      required this.controller,
      required this.afterBlankText,
      this.hint = '_',
      required this.blankSize,
      Key? key})
      : super(key: key);

  @override
  State<FormatFillInTheBlanks> createState() => _FormatFillInTheBlanksState();
}

class _FormatFillInTheBlanksState extends State<FormatFillInTheBlanks> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 1.5,
                fontWeight: FontWeight.bold),
            children: <InlineSpan>[
          TextSpan(
              text: widget.beforeBlankText,
              style: const TextStyle(
                  height: 1.0,
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "pakistan",
              answerLength: widget.blankSize,
              controller: widget.controller,
              answerHint: widget.hint,
            ),
          ),
          TextSpan(
              text: widget.afterBlankText,
              style: const TextStyle(
                  height: 1.0,
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ]));
  }
}

class SecretWord extends StatelessWidget {
  final String answer;
  final int answerLength;
  final String answerHint;
  final double answerWidth;
  final TextEditingController controller;

  SecretWord({
    Key? key,
    required this.answer,
    required this.controller,
    required this.answerLength,
    this.answerHint = '_',
    this.answerWidth = 10,
  }) : super(key: key);

  String value = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //alignment: Alignment.bottomCenter,
        width: answerWidth * answerLength,
        height: null,

        //  margin: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
            maxLines: null,
            cursorColor: Colors.cyanAccent,
            cursorRadius: const Radius.circular(12.0),
            cursorWidth: 2.0,
            style: TextStyle(
              color: (value == answer) ? Colors.grey : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              //  height: 0.5,
            ),
            //textAlign: TextAlign.left,
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              //labelText: 'Name *',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
              hintText: answerHint,
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                // height: 0.5,
              ),
            )));
  }
}
