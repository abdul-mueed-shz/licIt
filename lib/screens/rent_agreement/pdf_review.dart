import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;


class PdfReview {
  static Future<File> generateCenteredText(
      String? rentalAgreementLocation,
      String? rentalAgreementDate,
      String? rentalAgreementUserNameFrom,
      String? rentalAgreementGender,
      String? rentalAgreementAge,
      String? rentalAgreementResiding,
      String? rentalAgreementUserAddressFrom,
      String? rentalAgreementUserCityFrom,
      String? rentalAgreementUserAreaCodeFrom,
      String? rentalAgreementUserCountryFrom,
      String? rentalAgreementUserCnicFrom,
      String? rentalAgreementUserNameTO,
      String? rentalAgreementUserGender,
      String? rentalAgreementUserAgeTo,
      String? rentalAgreementUserResidingTo,
      String? rentalAgreementUserAddressTo,
      String? rentalAgreementUserCityTo,
      String? rentalAgreementUserAreaCodeTo,
      String? rentalAgreementUserCountryTo,
      String? rentalAgreementUserCnicTo,
      String? rentalAgreementUserHouse,
      String? rentalAgreementUserHouseBlock,
      String? rentalAgreementUserHouseAddress,
      String? rentalAgreementUserHouseCity,
      String? rentalAgreementUserHouseAreaCode,
      String? rentalAgreementUserHouseCountry,
      String? rentalAgreementUserHouseBedroom,
      String? rentalAgreementUserHouseBathroom,
      String? rentalAgreementUserHouseBalconey,
      String? rentalAgreementUserHouseCarPorch,
      String? rentalAgreementUserHousekitchen,
      String? rentalAgreementUserHouseAnyFitting) async {
    // making a pdf document to store a text and it is provided by pdf pakage
    final pdf = Document();

    // Text is added here in center
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.only(left: 40),
                child: pw.Text('Licit Agreement',
                    style: pw.TextStyle(fontSize: 30)),
              ),
              pw.SizedBox(height: 60),
              pw.Text(
                  'THIS AGREEMENT is made and executed at  ( ${rentalAgreementLocation}) on ( ${rentalAgreementDate} ),by and between (${rentalAgreementUserNameFrom}),(${rentalAgreementGender}),age (${rentalAgreementAge}) years, residing at ( ${rentalAgreementResiding} ), (${rentalAgreementUserAddressTo}),(${rentalAgreementUserCityTo}), ........... (${rentalAgreementUserAreaCodeTo}), (${rentalAgreementUserCountryTo}) and having ID card No. ${rentalAgreementUserCnicTo}. (here in after jointly and severally called the \B Landlord, which expression shall include his heirs, legal representatives, successors and assigns).',
                  style: pw.TextStyle(fontSize: 14, height: 6),
                  textAlign: TextAlign.justify),
              pw.SizedBox(height: 30),
              pw.Text('And'),
              pw.SizedBox(height: 30),
              pw.Text(
                  '($rentalAgreementUserNameTO), ($rentalAgreementUserGender),aged ($rentalAgreementUserAgeTo) years .having permanent address at ($rentalAgreementUserResidingTo), ($rentalAgreementUserAddressTo),($rentalAgreementUserCityTo).... ......,($rentalAgreementUserAreaCodeTo), ($rentalAgreementUserCountryTo) and having ID card No. $rentalAgreementUserCnicTo. (hereinafter called the “Tenant", which expression shall include his legal representatives, successors and assigns).',
                  style: pw.TextStyle(fontSize: 14, height: 6),
                  textAlign: TextAlign.justify),
              pw.SizedBox(height: 10),
              pw.Text(
                  'WHEREAS the Landlord is the absolute owner of the $rentalAgreementUserHouse House situated at ($rentalAgreementUserHouseBlock), ($rentalAgreementUserHouseAddress), ($rentalAgreementUserHouseCity), ...................., ($rentalAgreementUserHouseAreaCode), ($rentalAgreementUserHouseCountry), consisting of ($rentalAgreementUserHouseBedroom), ($rentalAgreementUserHouseBathroom), ($rentalAgreementUserHouseBalconey),($rentalAgreementUserHouseCarPorch), ($rentalAgreementUserHousekitchen) and $rentalAgreementUserHouseAnyFitting & fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises".',
                  style: pw.TextStyle(fontSize: 14, height: 6),
                  textAlign: TextAlign.justify),
            ])));

    // passing the pdf and name of the docoment to make a direcotory in  the internal storage
    return saveDocument(name: 'myContract.pdf', pdf: pdf);
  }

  // it will make a named dircotory in the internal storage and then return to its call
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();

    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
    return file;
  }

// here we use a pakage to open the existing file that we make now.
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}