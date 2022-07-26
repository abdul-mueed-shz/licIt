import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class JobAgreementPreviewScreen extends StatefulWidget {
  static const String routeName = '/PreviewScreen';
  const JobAgreementPreviewScreen({Key? key}) : super(key: key);

  @override
  State<JobAgreementPreviewScreen> createState() => _JobAgreementPreviewScreenState();
}

class _JobAgreementPreviewScreenState extends State<JobAgreementPreviewScreen> {
  final contractModel = storage.contract;
  String cnic = PrefStorage.instance.id ?? '';
  final style=GoogleFonts.spartan(
      height: 2,
      fontSize: 12,
      color: Colors.black,
      wordSpacing: 2,
      fontWeight: FontWeight.bold);

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(
                  'Job Offer and Employment Contract',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 28),

                Align(alignment:Alignment.topLeft ,child: Text('Private and confidential',style: style,)),
                const SizedBox(height: 30),
                Align(alignment:Alignment.topLeft ,child: Text('Abdul Moeed Shahbaz',style: style,)),
                const SizedBox(height: 10),

                Align(alignment:Alignment.topLeft ,child: Text('Street Number 54, Jaloo, Lahore, Punjab, 55056, Pakistan',style: style,)),
                const SizedBox(height: 10),
                Align(alignment:Alignment.topLeft ,child: Text('Offer of Employment',style: style)),
                const SizedBox(height: 10),
                Align(alignment:Alignment.topLeft ,child: Text('Dear,',style: style)),

                Text(
                  'With reference to your application for employment and the subsequent interview you had with us, we are pleased to offer you employment with   (${contractModel?.userCityFrom})',
                  style:  style,
                  textAlign: TextAlign.justify,
                ),

                Align(alignment:Alignment.topLeft ,child: Text('on the following terms and conditions.',style: style)),
                const SizedBox(height: 5),                Align(alignment:Alignment.topLeft ,child: Text('Our Company is An FYP ka aidea',style: style)),
                Text(
                  ' This offer is subject to the fulfillment of the pre-contractual conditions of you being found medically fit and verification done by the Company of the accuracy of testimonials and information provided by you.',
                  style:  style,
                  textAlign: TextAlign.justify,
                ),

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
