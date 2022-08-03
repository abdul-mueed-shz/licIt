import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GeneralTemplate extends StatefulWidget {
  static const String routeName = '/GeneralTemplate';
  const GeneralTemplate({Key? key}) : super(key: key);

  @override
  State<GeneralTemplate> createState() => _GeneralTemplateState();
}

class _GeneralTemplateState extends State<GeneralTemplate> {
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
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: formDataKey,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                              "\t\t\t\t\tNon-Disclosure\nConfidently Agreement",
                              style: GoogleFonts.spartan(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  letterSpacing: 2)),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: FittedBox(
                            child: Row(
                              children: [
                                Text(
                                  'This Agreement Date is Entered into onto:   ',
                                  maxLines: 1,
                                  style: GoogleFonts.spartan(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 15),
                                  child: DateTimeField(
                                    onDateTimeChanged:
                                        provider.onStartTemplateSelectedDate,
                                    title: '',
                                    defaultValue:
                                        provider.selectedStartDateTemplate,
                                    delay: 300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Between M/s .",
                                maxLines: 1,
                                style: GoogleFonts.spartan(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: CustomTextField(
                                    controller: provider.templateUserNameFrom,
                                    title: 'User1',
                                    inputType: TextInputType.name,
                                    validator: Validator.basicValidator),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ",addressed at",
                                style: GoogleFonts.spartan(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomTextField(
                                  controller: provider.templateUserAddressFrom,
                                  title: 'Address',
                                  inputType: TextInputType.streetAddress,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserLocalityFrom,
                                  title: 'Locality',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserCityFrom,
                                  title: 'City',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserProvinceFrom,
                                  title: 'Province',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                          ],
                        ),
                        CustomTextField(
                            controller: provider.templateUserCountryFrom,
                            title: 'Country',
                            inputType: TextInputType.text,
                            validator: Validator.basicValidator),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            "here in after referred to as the disclosing party",
                            style: GoogleFonts.spartan(
                                fontSize: 11, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text("And",
                            style: GoogleFonts.spartan(
                                color: Colors.green, fontSize: 30)),
                        Text(
                            "\n\nAgreement shall remain in effect for a period of \n\n",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.spartan(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25, right: 50),
                          child: CustomTextField(
                              controller: provider.templateUserEndYear,
                              title: 'Years',
                              inputType: TextInputType.number,
                              validator: Validator.basicValidator),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "M/s.",
                              style: GoogleFonts.spartan(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: CustomTextField(
                                    controller: provider.templateNameUserTo,
                                    title: 'User 2',
                                    validator: Validator.basicValidator),
                              ),
                            ),
                            Text(
                              ",addressed at",
                              style: GoogleFonts.spartan(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: CustomTextField(
                                    controller: provider.templateUserAddressTo,
                                    title: 'Address',
                                    inputType: TextInputType.streetAddress,
                                    validator: Validator.basicValidator),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserLocalityTo,
                                  title: 'Locality',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserCityTo,
                                  title: 'City',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                            child: CustomTextField(
                                controller: provider.templateUserProvinceTo,
                                title: 'Province',
                                inputType: TextInputType.text,
                                validator: Validator.basicValidator),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CustomTextField(
                                controller: provider.templateUserCountryTo,
                                title: 'Country',
                                inputType: TextInputType.text,
                                validator: Validator.basicValidator),
                          ),
                        ]),
                        const SizedBox(height: 20),
                        Text(
                          "Here in after referred to as the Receiving Party  collectively referred to as the \"Parties\".\n\n"
                          '\n\n1. Purpose of Agreement\n\n'
                          'To prohibit unauthorized disclosure of proprietary and confidential information which are disclosed by the Disclosing party to the Receiving party either prior to this agreement or after that. All such information is referred to as "proprietary information" or "confidential information".\n\n'
                          ' \n2. Confidential or Proprietary information\n '
                          ' \n\n1.	These shall be included as confidential information - any data or information that is proprietary to the Disclosing Party and not generally known to the public whether by written or oral means and includes any marketing, financial, operational, sales or any other business plans or product or service or customer information of the past, present or future of the disclosing party or any scientific or technical information, invention, design, process, procedure, formula, technology or method or any concepts, reports, data, development tools, computer software and programs, trade secrets and any other information recognized as confidential information of the Disclosing Party.\n\n'
                          '\n\n2.	The following shall not be considered as confidential information:\n\n'
                          '\n\na.	Information that was known by the Receiving Party prior to receiving the Confidential Information from the Disclosing Party or'
                          '\n\nb.	Known to the Receiving Party from a third-party source and the Receiving Party not knowing to be under an obligation to Disclosing Party to maintain confidentiality or'
                          '\n\nc.	Becomes publicly available through no fault of the Receiving Party or'
                          '\n\nd.	Is required to be disclosed in a judicial or administrative proceeding, or is required to be disclosed by law or regulation.\n\n'
                          '\n\n 3.	Terms and conditions\n\n'
                          ' \n\na.	Non-Disclosure: The Receiving Party acknowledges and understands that the Confidential Information is proprietary to the Disclosing Party. The Receiving party shall hold the Proprietary Information in strict confidence and take all precautions to protect such Proprietary Information and not disclose any such confidential Proprietary Information to any third person.\n\n'
                          '\n\n b.	Non-Use: The Receiving party shall not at any time, make any use or copy or modify or publish such Proprietary Information except to be used solely in connection with business relationship between the parties and not for any purpose other than as authorized by this agreement without the prior written consent of the Disclosing Party. The Receiving party shall not have any other right or title on the Confidential information. Title to the Confidential Information will remain solely in the Disclosing Party and any modifications and improvements made by the Receiving Party shall be the sole property of the Disclosing Party.\n\n'
                          '\n\nc.	Sub-Contract: The Receiving Party shall sign and procure a nondisclosure or similar agreement in content substantially similar to this Agreement with its employees, agents and subcontractors to whom Proprietary Information is disclosed or who have access to it.\n\n'
                          '\n\nd.	Termination and Return of proprietary materials: Receiving Party shall immediately return to the Disclosing Party all Proprietary Information and all documents or content containing any such Proprietary Information and all copies or extracts of the same Information upon (1) The completion of the dealings between the parties. (2) The termination of this Agreement; or (3) On written request by the Disclosing Party at any time. And also to erase or destroy such information that has been copied or transcribed into another document and cannot be returned.\n\n'
                          ' \n\ne.	Not to Assign, Transfer or Amend: This Agreement shall not be assigned, transferred or amended, partly or wholly without the consent of the other Party.\n\n'
                          ' \n\nf.	Effective Period: The rights and obligations of each Party with respect to all Confidential Information of the other Party that is received under this Agreement, shall remain in effect for a period of from the date of disclosure of Confidential Information.\n\n'
                          '\n\ng.	Governing Law: In case of any disputes arising out of or in relation to this agreement, the parties submit to the jurisdiction of courts in Pakistan situated in OR Arbitration: In case of disputes, this agreement shall be subject to the decisions of an Arbitrator mutually agreed upon by the parties to this agreement in.\n\n'
                          '\n\nh.	Enforceability: If any of the provisions of this agreement is termed illegal or unenforceable, in whole or part, only such terms will be deemed to be excluded and the rest of the provisions and clauses shall be unaffected and remain valid and enforceable.\n\n'
                          '\n\ni.	Breach and Relief: Any unauthorized use or disclosure of Confidential Information by Receiving Party or its Representatives amounts to breach and the Receiving Party shall notify the Disclosing Party immediately upon discovery of such breach and shall cooperate to help the Disclosing Party regain possession of Confidential Information and prevent its further unauthorized use. The Disclosing Party shall be entitled to injunctive relief preventing the dissemination of any Confidential Information in violation of the terms of this Agreement and such injunctive relief shall be in addition to any other remedies available under law or in equity. Disclosing Party shall be entitled to recover its costs.\n\n'
                          '\n\nThis Agreement constitutes the entire understanding between the parties and supersedes all prior agreements or understandings.\n\n',
                          style: GoogleFonts.spartan(fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 40),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: DeleteBacKFunctionality(
                                  iconData:
                                      Icons.keyboard_double_arrow_left_outlined,
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
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteTap(BuildContext context) {}
  void _homeBack(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(TabScreen.routeName));
  }

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
      Navigator.pushNamed(context, WarningScreen.routeName);
    }
  }
}
