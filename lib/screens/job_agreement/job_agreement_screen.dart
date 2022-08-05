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
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text("Job Offer & Employment Contract",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.spartan(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        letterSpacing: 2)),
                              ),
                              const SizedBox(height: 20),
                              const Align(
                                alignment: Alignment.center,
                                child: Text('Private and confidential'),
                              ),
                              const SizedBox(height: 20),
                              FormatFillInTheBlanks(
                                beforeBlankText: '',
                                afterBlankText: '',
                                hint: 'Full Name',
                                blankSize: 20,
                                controller: provider.jobUserName,
                              ),
                              Wrap(
                                children: [
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'Street',
                                      afterBlankText: ', ',
                                      blankSize: 7,
                                      controller: provider.jobAddress),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'Area',
                                      afterBlankText: ', ',
                                      blankSize: 7,
                                      controller: provider.jobName),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'City',
                                      afterBlankText: ', ',
                                      blankSize: 7,
                                      controller: provider.jobCity),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'Province',
                                      afterBlankText: ', ',
                                      blankSize: 7,
                                      controller: provider.jobProvince),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'ZIP Code',
                                      afterBlankText: ', ',
                                      blankSize: 7,
                                      controller: provider.jobPostalCode),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: '',
                                      hint: 'Country',
                                      afterBlankText: '',
                                      blankSize: 7,
                                      controller: provider.jobCountry)
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text('Offer of Employment'),
                              const SizedBox(height: 20),
                              const Text('Dear,'),
                              const SizedBox(height: 20),
                              FormatFillInTheBlanks(
                                  beforeBlankText:
                                      'With reference to your application for employment and the subsequent interview you had with us, we are pleased to offer you employment with ',
                                  hint: 'company name',
                                  afterBlankText:
                                      ' on the following terms and conditions.',
                                  blankSize: 11,
                                  controller: provider.companyName),
                              const SizedBox(height: 20),
                              FormatFillInTheBlanks(
                                  beforeBlankText: 'Our company is ',
                                  hint: 'details',
                                  afterBlankText: '.',
                                  blankSize: 20,
                                  controller: provider.companyDetails),
                              const Text(
                                'This offer is subject to the fulfillment of the pre-contractual conditions of you being found medically fit and verification done by the company of the accuracy of testimonials and information provided by you.',
                                style: TextStyle(fontSize: 12, height: 1.5),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Terms and conditions:',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '1. Commencement of Employment',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FormatFillInTheBlanks(
                                  beforeBlankText:
                                      'Your employment would be effective from ',
                                  hint: 'date',
                                  afterBlankText: '.',
                                  blankSize: 10,
                                  controller: provider.employmentStartingDate),
                              const Text(
                                '2. Job Title',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Wrap(
                                children: [
                                  FormatFillInTheBlanks(
                                      beforeBlankText:
                                          'You shall be employed as ',
                                      hint: 'role',
                                      afterBlankText: '',
                                      blankSize: 5,
                                      controller: provider.jobRole),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: ' in our office at ',
                                      hint: 'location',
                                      afterBlankText: '.',
                                      blankSize: 7,
                                      controller: provider.officeLocation),
                                ],
                              ),
                              const Text(
                                '3. Remuneration',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Wrap(
                                children: [
                                  FormatFillInTheBlanks(
                                      beforeBlankText:
                                          'Your total Remuneration will be Rs ',
                                      hint: '20000',
                                      afterBlankText: '/-',
                                      blankSize: 5,
                                      controller: provider.jobRole),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: ' (Rupees ',
                                      hint: 'Twenty Thousand',
                                      afterBlankText:
                                          'Only) per annum. A detailed break-up of the remuneration is given below:',
                                      blankSize: 13,
                                      controller: provider.officeLocation),
                                ],
                              ),
                              Wrap(
                                children: [
                                  FormatFillInTheBlanks(
                                      beforeBlankText: 'HRA Rs ',
                                      hint: '3000',
                                      afterBlankText: ',',
                                      blankSize: 4,
                                      controller: provider.officeLocation),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: 'Provident Fund Rs ',
                                      hint: '2000',
                                      afterBlankText: ',',
                                      blankSize: 4,
                                      controller: provider.officeLocation),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: 'Medical Insurance Rs ',
                                      hint: '2500',
                                      afterBlankText: ',',
                                      blankSize: 4,
                                      controller: provider.officeLocation),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: 'Transport Rs ',
                                      hint: '5000',
                                      afterBlankText: ',',
                                      blankSize: 4,
                                      controller: provider.officeLocation),
                                  FormatFillInTheBlanks(
                                      beforeBlankText: 'and others Rs ',
                                      hint: '150',
                                      afterBlankText: '.',
                                      blankSize: 4,
                                      controller: provider.officeLocation),
                                ],
                              ),
                              const Text(
                                '4. Tax deductions',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'Appropriate amount of income tax payable by you under the Income Tax Act, shall be deducted from your salary by the Company. You shall file the personal returns and comply with other requirements under the Tax laws.',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '5. Hours of Work',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'You are required to work for a total of 8 hours per week. You are also required to work in shifts depending on the project or department working hours as required by the Company.',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '6. Probation Period',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'You will be placed on probation for a period of one month from the date of joining the services and will continue till a confirmation is provided to you by the company. The confirmation will be communicated to you in writing.',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '7. Annual Earned Leave',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'You are eligible for 25 days of annual leave that will be accrued on a monthly basis.',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '8. Place of Work',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'You will report into the company office',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'The Company may in its sole discretion and at any point of time give you reasonable notice and assign or transfer your services to any place of business of the Company presently operating or in any of its future branches in any part of India or abroad. In such case, the terms and conditions governing your service shall be those applicable at the location of transfer or those applicable to employees of such branches.',
                                style: TextStyle(fontSize: 12),
                              ),
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
                                    child:
                                        MyElevatedButton('Next', onTap: _tap),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: DeleteBacKFunctionality(
                                        iconData: Icons.delete,
                                        onTap: _deleteTap),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
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
        children: <InlineSpan>[
          TextSpan(
              text: widget.beforeBlankText,
              style: const TextStyle(color: Colors.black, fontSize: 12)),
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
              style: const TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
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
                letterSpacing: 2,
                // height: 0.5,
              ),
            )));
  }
}
