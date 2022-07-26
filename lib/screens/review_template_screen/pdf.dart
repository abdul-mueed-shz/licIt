import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(
      String startDate,
      String contractID,
      String? contractName,
      String endDate,
      String reviewImage,
      String requestImage,
      bool witnessShow,
      String? witness1Id,
      String? witness2Id,
      String userNameFrom,
      String userNameTo,
      String userAddressFrom,
      String userAddressTo,
      String userCityFrom,
      String userCityTo,
      String receiverRequestId,
      String userCountryFrom,
      String userCountryTo,
      String userLocalityFrom,
      String userLocalityTo,
      String userProvinceFrom,
      String warning,
      bool witnessStatus1,
      bool witnessStatus2,
      String userProvinceTo,
      String reviewRequestID,
      String selectedStatus) async {
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
                      'THIS AGREEMENT is made on ( ${startDate}) by and between ( ${userNameFrom} ), having permanent address at ( ${userAddressFrom} ), (${userCityFrom}), ........... (550005), (${userProvinceFrom}) and having ID card No. ${reviewRequestID}. (here in after jointly and severally called the \B Landlord, which expression shall include his heirs, legal representatives, successors and assigns).',
                      style: pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 30),
                  pw.Text('And'),
                  pw.SizedBox(height: 30),
                  pw.Text(
                      '($userNameTo), having permanent address at ($userAddressTo), ($userCityTo), ($userProvinceTo),.... ......,(544594), (Pakistan) and having ID card No. $receiverRequestId. (hereinafter called the “Tenant", which expression shall include his legal representatives, successors and assigns).',
                      style: pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      'WHEREAS the Landlord is the absolute owner of the Independent House situated at (R Block), (Model Town), (Lahore), ...................., (32423), (Pak), consisting of (2 bedrooms), (1 bathroom), (1 balcony),(1 car parking space), (1kitchen) and inbuilt fittings & fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises".',
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
