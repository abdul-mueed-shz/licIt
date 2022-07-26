import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/preview/preview_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
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
    final provider = context.read<PromiseProvider>();
    if (pref?.contractStartDate != null && pref?.contractEndDate != null) {
      provider.updateTemplateField();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PromiseProvider>();
    return Scaffold(
      body: LayoutBuilder(
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
                      child: Text("\t\t\t\t\tJob Offer\nEmployment Contract",
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
                            callBack: (String value) {
                              print(value);
                            })),
                    Row(
                      children: [
                        FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: 'Street Number 54',
                            afterBlankText: ',',
                            blankSize: 18,
                            callBack: (String value) {
                              print(value);
                            }),
                        FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: 'Jaloo',
                            afterBlankText: ',',
                            blankSize: 10,
                            callBack: (String value) {
                              print(value);
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: 'Lahore',
                            afterBlankText: ',',
                            blankSize: 10,
                            callBack: (String value) {
                              print(value);
                            }),
                        FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: 'Punjab',
                            afterBlankText: ',',
                            blankSize: 10,
                            callBack: (String value) {
                              print(value);
                            }),
                        FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: '55056',
                            afterBlankText: ',',
                            blankSize: 10,
                            callBack: (String value) {
                              print(value);
                            }),
                      ],
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: FormatFillInTheBlanks(
                            beforeBlankText: '',
                            hint: 'Pakistan',
                            afterBlankText: ',',
                            blankSize: 10,
                            callBack: (String value) {
                              print(value);
                            })),
                    const SizedBox(height: 20),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Offer of Employment')),
                    const SizedBox(height: 20),
                    const Align(
                        alignment: Alignment.topLeft, child: Text('Dear,')),
                    const SizedBox(height: 20),
                    FormatFillInTheBlanks(
                        beforeBlankText:
                            'With reference to your application for employment and the subsequent interview you had with us, we are pleased to offer you employment with ',
                        hint: 'LICIT',
                        afterBlankText:
                            'on the following terms and conditions.',
                        blankSize: 7,
                        callBack: (String value) {
                          print(value);
                        }),
                    const SizedBox(height: 5),
                    FormatFillInTheBlanks(
                        beforeBlankText: 'Our Company is ',
                        afterBlankText: ',',
                        hint: 'An FYP ka aidea',
                        blankSize: 25,
                        callBack: (String value) {
                          print(value);
                        }),
                    const Text(
                        'This offer is subject to the fulfillment of the pre-contractual conditions of you being found medically fit and verification done by the Company of the accuracy of testimonials and information provided by you.')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteTap(BuildContext context) {}

  void _tap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();
    if (formDataKey.currentState!.validate()) {
      if (provider.selectedStartDateTemplate == null) {
        return EasyLoading.showError("Starting Date Can't Be Null");
      }
      final years = int.parse(provider.templateUserEndYear.text);
      final calculateDays = years * 365;

      final date = provider.selectedStartDateTemplate ?? DateTime.now();
      final endDate = date.add(Duration(days: calculateDays));
      provider.updateGeneralTextField(endDate.toString());
      Timer(const Duration(seconds: 2),
          () => Navigator.pushNamed(context, PreviewScreen.routeName));
    }
  }
}

class FormatFillInTheBlanks extends StatefulWidget {
  final String beforeBlankText;
  final String afterBlankText;
  final int blankSize;
  final Function callBack;
  final String hint;
  const FormatFillInTheBlanks(
      {required this.beforeBlankText,
      required this.callBack,
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
              callBack: (String value) => widget.callBack(value),
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
  final Function callBack;

  SecretWord({
    Key? key,
    required this.answer,
    required this.callBack,
    required this.answerLength,
    this.answerHint = '_',
    this.answerWidth = 10,
  }) : super(key: key);

  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onChanged: (text) {
              callBack(text);
              value = text;
            },
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
