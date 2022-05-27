import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../promise_agreement/promise_agreement.dart';

class GeneralTemplate extends StatefulWidget {
  static const String routeName = '/GeneralTemplate';
  const GeneralTemplate({Key? key}) : super(key: key);

  @override
  State<GeneralTemplate> createState() => _GeneralTemplateState();
}

class _GeneralTemplateState extends State<GeneralTemplate> {
  final formDataKey = GlobalKey<FormState>();

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text("Non-Disclosure/Confidently Agreement",
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'This Agreement is entered into a Date:',
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Between M/s .",
                              maxLines: 1,
                              style:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 120,
                              child: CustomTextField(
                                  controller: provider.templateUserNameFrom,
                                  title: 'User1',
                                  inputType: TextInputType.name,
                                  validator: Validator.basicValidator),
                            ),
                            Text(
                              ",addressed at",
                              style:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomTextField(
                                  controller: provider.templateUserAddressFrom,
                                  title: 'Address',
                                  inputType: TextInputType.streetAddress,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 20),
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserCountryFrom,
                                  title: 'Country',
                                  inputType: TextInputType.text,
                                  validator: Validator.basicValidator),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "here in after refered to as the Disclosing \n party",
                              style: GoogleFonts.lato(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("And", style: GoogleFonts.lato(fontSize: 30)),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                  "Agreement shall remain in effect for a period of ",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(
                                    controller: provider.templateUserEndYear,
                                    title: 'Years',
                                    inputType: TextInputType.number,
                                    validator: Validator.basicValidator))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "M/s.",
                              style: GoogleFonts.lato(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateNameUserTo,
                                  title: 'User 2',
                                  validator: Validator.basicValidator),
                            ),
                            Text(
                              ",addressed at",
                              style:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.templateUserAddressTo,
                                  title: 'Address',
                                  inputType: TextInputType.streetAddress,
                                  validator: Validator.basicValidator),
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
                            const SizedBox(width: 5),
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
                          ],
                        ),
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

      Navigator.pushNamed(context, SearchScreen.routeName);
    }
  }
}
