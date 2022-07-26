import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/preview/preview_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
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
                                  'This Agreement Date is:   ',
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
                            "here in after refered to as the disclosing party",
                            style: GoogleFonts.spartan(
                                fontSize: 11, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text("And",
                            style: GoogleFonts.spartan(
                                color: Colors.green, fontSize: 30)),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                  "Agreement shall remain in effect for a period of ",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.spartan(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: CustomTextField(
                                  controller: provider.templateUserEndYear,
                                  title: 'Years',
                                  inputType: TextInputType.number,
                                  validator: Validator.basicValidator),
                            ))
                          ],
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
                          "Here in after referred to as the Receiving Party  collectively referred to as the \"Parties\" ",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        const Spacer(),
                        Row(
                          children: [
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
