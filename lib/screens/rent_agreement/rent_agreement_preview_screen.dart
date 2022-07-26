import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RentAgreementPreviewScreen extends StatefulWidget {
  static const String routeName = '/PreviewScreen';
  const RentAgreementPreviewScreen({Key? key}) : super(key: key);

  @override
  State<RentAgreementPreviewScreen> createState() => _RentAgreementPreviewScreenState();
}

class _RentAgreementPreviewScreenState extends State<RentAgreementPreviewScreen> {
  final contractModel = storage.contract;
  String cnic = PrefStorage.instance.id ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Contract'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.navigate_before),
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, WarningScreen.routeName),
              icon: const Icon(Icons.navigate_next_sharp),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Rental Agreement',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  'THIS AGREEMENT is made and executed at  (${contractModel?.userCityFrom}) on ( ${getDate()}) by and between ( ${contractModel?.userNameFrom} ) years, ( ${contractModel?.userAddressFrom} ), (${contractModel?.userCityFrom}), ........... (550005), (${contractModel?.userProvinceFrom}) and having ID card No. ${cnic}. (hereinafter jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns).',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                const Text('AND'),
                Text(
                  ' (${contractModel?.userNameTo}), having permanent address ), ( ${contractModel?.userAddressTo} ), (${contractModel?.userCityFrom}),.... ......,(544594), (${contractModel?.userProvinceFrom}) and having ID card No. ${cnic}. (hereinafter called the “Tenant", which expression shall include his legal representatives, successors and assigns).',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'WHEREAS the Landlord is the absolute owner of the Independent House situated at (R Block), (Model Town), (Lahore), ...................., (32423), (Pak), consisting of (2 bedrooms), (1 bathroom), (1 balcony),(1 car parking space), (1kitchen) and inbuilt fittings & fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises".',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ));
  }

  String getDate() {
    String date = contractModel?.contractStartDate ?? '';
    print(date);
    final dateTime = DateTime.parse(date);
    final formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }
}
