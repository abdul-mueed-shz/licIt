import 'dart:io';

import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
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
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 40),
                    child: pw.Text('Licit Agreement',
                        style: const pw.TextStyle(fontSize: 30)),
                  ),
                  pw.SizedBox(height: 60),
                  pw.Text(
                      'This Agreement is entered into on Date: $startDate\t\tBetween M/s \t\t$userNameFrom ,addressed at  $userAddressFrom, $userLocalityFrom ,$userCityFrom, $userProvinceFrom $userCountryFrom, hereinafter referred to as the Disclosing party',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 30),
                  pw.Text('And'),
                  pw.SizedBox(height: 30),
                  pw.Text(
                      'M/s .\t\t$userNameTo,\t\taddressed at \t\t$userAddressTo ,\t\t$userLocalityTo,\t\t$userCityTo,\t\t$userProvinceTo,\t\t$userCountryTo',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      "Here in after referred to as the Receiving Party  collectively referred to as the \"Parties\".\n\n",
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n1. Purpose of Agreement \n\n To prohibit unauthorized disclosure of proprietary and confidential information which are disclosed by the Disclosing party to the Receiving party either prior to this agreement or after that. All such information is referred to as "proprietary information" or "confidential information".\n\n \n 2. Confidential or Proprietary information\n  \n\n1.	These shall be included as confidential information - any data or information that is proprietary to the Disclosing Party and not generally known to the public whether by written or oral means and includes any marketing, financial, operational, sales or any other business plans or product or service or customer information of the past, present or future of the disclosing party or any scientific or technical information, invention, design, process, procedure, formula, technology or method or any concepts, reports, data, development tools, computer software and programs, trade secrets and any other information recognized as confidential information of the Disclosing Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n2.	The following shall not be considered as confidential information:\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\na.	Information that was known by the Receiving Party prior to receiving the Confidential Information from the Disclosing Party or ',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nb.	Known to the Receiving Party from a third-party source and the Receiving Party not knowing to be under an obligation to Disclosing Party to maintain confidentiality or',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nc.	Becomes publicly available through no fault of the Receiving Party or',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nd.	Is required to be disclosed in a judicial or administrative proceeding, or is required to be disclosed by law or regulation.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text('\n\n 3.	Terms and conditions\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\na.	Non-Disclosure: The Receiving Party acknowledges and understands that the Confidential Information is proprietary to the Disclosing Party. The Receiving party shall hold the Proprietary Information in strict confidence and take all precautions to protect such Proprietary Information and not disclose any such confidential Proprietary Information to any third person.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n b.	Non-Use: The Receiving party shall not at any time, make any use or copy or modify or publish such Proprietary Information except to be used solely in connection with business relationship between the parties and not for any purpose other than as authorized by this agreement without the prior written consent of the Disclosing Party. The Receiving party shall not have any other right or title on the Confidential information. Title to the Confidential Information will remain solely in the Disclosing Party and any modifications and improvements made by the Receiving Party shall be the sole property of the Disclosing Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nc.	Sub-Contract: The Receiving Party shall sign and procure a nondisclosure or similar agreement in content substantially similar to this Agreement with its employees, agents and subcontractors to whom Proprietary Information is disclosed or who have access to it.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nd.	Termination and Return of proprietary materials: Receiving Party shall immediately return to the Disclosing Party all Proprietary Information and all documents or content containing any such Proprietary Information and all copies or extracts of the same Information upon (1) The completion of the dealings between the parties. (2) The termination of this Agreement; or (3) On written request by the Disclosing Party at any time. And also to erase or destroy such information that has been copied or transcribed into another document and cannot be returned.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\ne.Not to Assign, Transfer or Amend: This Agreement shall not be assigned, transferred or amended, partly or wholly without the consent of the other Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\nf.	Effective Period: The rights and obligations of each Party with respect to all Confidential Information of the other Party that is received under this Agreement, shall remain in effect for a period of from the date of disclosure of Confidential Information.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\ng.	Governing Law: In case of any disputes arising out of or in relation to this agreement, the parties submit to the jurisdiction of courts in Pakistan situated in OR Arbitration: In case of disputes, this agreement shall be subject to the decisions of an Arbitrator mutually agreed upon by the parties to this agreement in.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      )),
                  pw.Text(
                      '\n\nh.	Enforceability: If any of the provisions of this agreement is termed illegal or unenforceable, in whole or part, only such terms will be deemed to be excluded and the rest of the provisions and clauses shall be unaffected and remain valid and enforceable.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\ni.	Breach and Relief: Any unauthorized use or disclosure of Confidential Information by Receiving Party or its Representatives amounts to breach and the Receiving Party shall notify the Disclosing Party immediately upon discovery of such breach and shall cooperate to help the Disclosing Party regain possession of Confidential Information and prevent its further unauthorized use. The Disclosing Party shall be entitled to injunctive relief preventing the dissemination of any Confidential Information in violation of the terms of this Agreement and such injunctive relief shall be in addition to any other remedies available under law or in equity. Disclosing Party shall be entitled to recover its costs.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nThis Agreement constitutes the entire understanding between the parties and supersedes all prior agreements or understandings.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
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

class MyPdfPromise {
  static Future<File> generateCenteredText(
    ContractModel contractModel,
    ReviewModel? reviewModel,
  ) async {
    // making a pdf document to store a text and it is provided by pdf pakage
    final pdf = Document();

    // Text is added here in center
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 40),
                    child: pw.Text('Licit Agreement',
                        style: const pw.TextStyle(fontSize: 30)),
                  ),
                  pw.SizedBox(height: 60),
                  pw.Text(
                      'This Agreement is entered into on Date: ${contractModel.contractStartDate}\t\tBetween M/s \t\t${contractModel.userNameFrom} ,addressed at  ${contractModel.userAddressFrom}, ${contractModel.userLocalityFrom} ,${contractModel.userCityFrom}, ${contractModel.userProvinceFrom}${contractModel.userCountryFrom}, hereinafter referred to as the Disclosing party',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 30),
                  pw.Text('And'),
                  pw.SizedBox(height: 30),
                  pw.Text(
                      'M/s .\t\t${contractModel.userNameTo},\t\taddressed at \t\t${contractModel.userAddressTo} ,\t\t${contractModel.userLocalityTo},\t\t${contractModel.userCityTo},\t\t${contractModel.userProvinceTo},\t\t${contractModel.userCountryTo}',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      'Additional Info :${contractModel.contractDetail?.warning ?? ''}',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      'This contract between ${reviewModel?.reviewName} (${reviewModel?.reviewRequestId}) and ${reviewModel?.requestName} (${reviewModel?.receiverRequestId})'),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      'with Witness ${contractModel.contractDetail?.witness1?.witnessId ?? ''} and ${contractModel.contractDetail?.witness2?.witnessId ?? ''}',
                      style: const pw.TextStyle(fontSize: 14, height: 6),
                      textAlign: TextAlign.justify),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      "Here in after referred to as the Receiving Party  collectively referred to as the \"Parties\".\n\n",
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n1. Purpose of Agreement \n\n To prohibit unauthorized disclosure of proprietary and confidential information which are disclosed by the Disclosing party to the Receiving party either prior to this agreement or after that. All such information is referred to as "proprietary information" or "confidential information".\n\n \n 2. Confidential or Proprietary information\n  \n\n1.	These shall be included as confidential information - any data or information that is proprietary to the Disclosing Party and not generally known to the public whether by written or oral means and includes any marketing, financial, operational, sales or any other business plans or product or service or customer information of the past, present or future of the disclosing party or any scientific or technical information, invention, design, process, procedure, formula, technology or method or any concepts, reports, data, development tools, computer software and programs, trade secrets and any other information recognized as confidential information of the Disclosing Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n2.	The following shall not be considered as confidential information:\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\na.	Information that was known by the Receiving Party prior to receiving the Confidential Information from the Disclosing Party or ',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nb.	Known to the Receiving Party from a third-party source and the Receiving Party not knowing to be under an obligation to Disclosing Party to maintain confidentiality or',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nc.	Becomes publicly available through no fault of the Receiving Party or',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nd.	Is required to be disclosed in a judicial or administrative proceeding, or is required to be disclosed by law or regulation.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text('\n\n 3.	Terms and conditions\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\na.	Non-Disclosure: The Receiving Party acknowledges and understands that the Confidential Information is proprietary to the Disclosing Party. The Receiving party shall hold the Proprietary Information in strict confidence and take all precautions to protect such Proprietary Information and not disclose any such confidential Proprietary Information to any third person.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\n b.	Non-Use: The Receiving party shall not at any time, make any use or copy or modify or publish such Proprietary Information except to be used solely in connection with business relationship between the parties and not for any purpose other than as authorized by this agreement without the prior written consent of the Disclosing Party. The Receiving party shall not have any other right or title on the Confidential information. Title to the Confidential Information will remain solely in the Disclosing Party and any modifications and improvements made by the Receiving Party shall be the sole property of the Disclosing Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nc.	Sub-Contract: The Receiving Party shall sign and procure a nondisclosure or similar agreement in content substantially similar to this Agreement with its employees, agents and subcontractors to whom Proprietary Information is disclosed or who have access to it.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nd.	Termination and Return of proprietary materials: Receiving Party shall immediately return to the Disclosing Party all Proprietary Information and all documents or content containing any such Proprietary Information and all copies or extracts of the same Information upon (1) The completion of the dealings between the parties. (2) The termination of this Agreement; or (3) On written request by the Disclosing Party at any time. And also to erase or destroy such information that has been copied or transcribed into another document and cannot be returned.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\ne.Not to Assign, Transfer or Amend: This Agreement shall not be assigned, transferred or amended, partly or wholly without the consent of the other Party.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      ' \n\nf.	Effective Period: The rights and obligations of each Party with respect to all Confidential Information of the other Party that is received under this Agreement, shall remain in effect for a period of from the date of disclosure of Confidential Information.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\ng.	Governing Law: In case of any disputes arising out of or in relation to this agreement, the parties submit to the jurisdiction of courts in Pakistan situated in OR Arbitration: In case of disputes, this agreement shall be subject to the decisions of an Arbitrator mutually agreed upon by the parties to this agreement in.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      )),
                  pw.Text(
                      '\n\nh.	Enforceability: If any of the provisions of this agreement is termed illegal or unenforceable, in whole or part, only such terms will be deemed to be excluded and the rest of the provisions and clauses shall be unaffected and remain valid and enforceable.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\ni.	Breach and Relief: Any unauthorized use or disclosure of Confidential Information by Receiving Party or its Representatives amounts to breach and the Receiving Party shall notify the Disclosing Party immediately upon discovery of such breach and shall cooperate to help the Disclosing Party regain possession of Confidential Information and prevent its further unauthorized use. The Disclosing Party shall be entitled to injunctive relief preventing the dissemination of any Confidential Information in violation of the terms of this Agreement and such injunctive relief shall be in addition to any other remedies available under law or in equity. Disclosing Party shall be entitled to recover its costs.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
                      textAlign: TextAlign.justify),
                  pw.Text(
                      '\n\nThis Agreement constitutes the entire understanding between the parties and supersedes all prior agreements or understandings.\n\n',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 6,
                      ),
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
