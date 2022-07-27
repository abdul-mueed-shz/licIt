import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/rent_agreement/rent_agreement_preview_screen.dart';
import 'package:fyp/screens/rent_agreement/rental_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentAgreementScreen extends StatefulWidget {
  static const String routeName = '/RentAgreementScreen';
  const RentAgreementScreen({Key? key}) : super(key: key);

  @override
  State<RentAgreementScreen> createState() => _RentAgreementScreenState();
}

class _RentAgreementScreenState extends State<RentAgreementScreen> {
  final formDataKey = GlobalKey<FormState>();

  @override
  void initState() {
    final pref = storage.contract;
    final provider = context.read<RentalProvider>();
    if (pref?.rentalAgreementUserNameTO != null &&
        pref?.rentalAgreementUserNameFrom != null) {
      provider.updateGeneralTextField();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Form(
                    key: formDataKey,
                    child: Column(
                      children: [
                        Text("\t\t\t\t\tRental Agreement",
                            style: GoogleFonts.spartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                letterSpacing: 2)),
                        const SizedBox(height: 60),
                        const FormatFillInTheBlanks(),
                        const SizedBox(height: 20),
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
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }

  void _homeBack(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(TabScreen.routeName));
  }

  void _deleteTap(BuildContext context) {}

  void _tap(BuildContext context) async {
    final provider = context.read<RentalProvider>();
    provider.updateGeneralTextField();
    if (formDataKey.currentState!.validate()) {
      final contract = storage.contract;
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamed(
              context, RentAgreementPreviewScreen.routeName,
              arguments: contract));
    }
  }
}

class FormatFillInTheBlanks extends StatefulWidget {
  const FormatFillInTheBlanks({Key? key}) : super(key: key);

  @override
  State<FormatFillInTheBlanks> createState() => _FormatFillInTheBlanksState();
}

class _FormatFillInTheBlanksState extends State<FormatFillInTheBlanks> {
  final style = const TextStyle(
      height: 1.0,
      color: Colors.grey,
      fontSize: 12,
      fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            height: 0.4,
            fontWeight: FontWeight.bold),
        children: <InlineSpan>[
          const TextSpan(
              text: 'THIS AGREEMENT is made and executed at',
              style: TextStyle(
                  height: 1.0,
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: SecretWord(
                    answer: "lahore",
                    answerLength: 15,
                    controller: provider.rentalAgreementLocation,
                    answerHint: 'Lahore')),
          ),
          TextSpan(
            text: 'on',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160),
                child: SecretWord(
                  answer: "lahore",
                  answerLength: 30,
                  controller: provider.rentalAgreementDate,
                  answerHint: ' 3rd March 2022',
                )),
          ),
          TextSpan(text: 'by and between ', style: style),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 60),
                child: SecretWord(
                  answer: "lahore",
                  answerLength: 15,
                  controller: provider.rentalAgreementUserNameFrom,
                  answerHint: ' Rafay',
                )),
          ),
          const TextSpan(
            text: ',',
            style: TextStyle(
                height: 1.0,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 8,
              controller: provider.rentalAgreementGender,
              answerHint: ' Male',
            ),
          ),
          TextSpan(
            text: 'aged',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 6,
              controller: provider.rentalAgreementAge,
              answerHint: ' 20',
            ),
          ),
          TextSpan(
            text: 'years ,',
            style: style,
          ),
          TextSpan(
            text: 'residing at',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementResiding,
              answerHint: ' itu',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 14,
              controller: provider.rentalAgreementUserAddressFrom,
              answerHint: ' Model Town',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCityFrom,
              answerHint: ' Lahore',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserAreaCodeFrom,
              answerHint: ' 550005',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCountryFrom,
              answerHint: ' Pakistan',
            ),
          ),
          TextSpan(
            text: 'and having ID card No. ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserCnicFrom,
              answerHint: ' 32635123368712351',
            ),
          ),
          TextSpan(
            text:
                'hereinafter jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          TextSpan(
            text: '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAnd',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserNameTO,
              answerHint: ' Moeed',
            ),
          ),
          const TextSpan(
            text: ',',
            style: TextStyle(
                height: 1.0,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 8,
              controller: provider.rentalAgreementUserGender,
              answerHint: ' Male',
            ),
          ),
          TextSpan(
            text: 'aged',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 6,
              controller: provider.rentalAgreementUserAgeTo,
              answerHint: ' 20',
            ),
          ),
          TextSpan(
            text: 'years ,',
            style: style,
          ),
          TextSpan(
            text: 'having permanent address at ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserResidingTo,
              answerHint: ' itu',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserAddressTo,
              answerHint: ' Model Town',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCityTo,
              answerHint: ' Lahore',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserAreaCodeTo,
              answerHint: ' 550005',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCountryTo,
              answerHint: ' Pakistan',
            ),
          ),
          TextSpan(
            text: 'and having ID card No. ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserCnicTo,
              answerHint: ' 32635123368712351',
            ),
          ),
          TextSpan(
            text:
                'hereinafter jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          TextSpan(
            text: 'WHEREAS the Landlord is the absolute owner of the',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouse,
              answerHint: ' Independent',
            ),
          ),
          TextSpan(text: 'House situated at ', style: style),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseBlock,
              answerHint: ' R Block',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseAddress,
              answerHint: ' Model Town',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseCity,
              answerHint: ' Lahore',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserHouseAreaCode,
              answerHint: ' 32423',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserHouseCountry,
              answerHint: ' Pak',
            ),
          ),
          TextSpan(
            text: 'consisting of ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 16,
              controller: provider.rentalAgreementUserHouseBedroom,
              answerHint: ' 2 bedrooms',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 16,
              controller: provider.rentalAgreementUserHouseBathroom,
              answerHint: ' 1 bathroom',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 13,
              controller: provider.rentalAgreementUserHouseBalconey,
              answerHint: ' 1 balcony',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserHouseCarPorch,
              answerHint: ' 1 car parking space',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHousekitchen,
              answerHint: ' 1kitchen',
            ),
          ),
          TextSpan(
            text: 'and',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserHouseAnyFitting,
              answerHint: ' inbuilt fittings',
            ),
          ),
          TextSpan(
            text:
                '& fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises',
            style: style,
          ),
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
    return Container(
        width: answerWidth * answerLength,
        height: null,

        //  margin: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
            maxLines: null,
            controller: controller,
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
