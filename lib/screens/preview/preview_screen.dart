import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/notification_review_back/notification_review_back.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewScreen extends StatefulWidget {
  static const String routeName = '/PreviewScreen';
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  String cnic = storage.id ?? '';

  @override
  Widget build(BuildContext context) {
    final contractModel =
        ModalRoute.of(context)?.settings.arguments as ContractModel;
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
              onPressed: () async {
                final contractDataModel = await contractRepository
                    .get(storage.contract?.id ?? '3123456789123');
                if (contractModel.isReviewState == true) {
                  Navigator.pushNamed(
                      context, NotificationScreenBack.routeName);
                  return;
                }
                if (contractDataModel?.contractDetail?.showSendOption == true) {
                  return;
                }
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              icon: const Icon(Icons.navigate_next_sharp),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Non-Disclosure\nConfidently Agreement',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spartan(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            letterSpacing: 2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This Agreement is entered into on Date: ${getDate(contractModel)}\t\tBetween M/s \t\t${contractModel.userNameFrom} ,addressed at  ${contractModel.userAddressFrom}, ${contractModel.userLocalityFrom} ,${contractModel.userCityFrom}, ${contractModel.userProvinceFrom} ${contractModel.userCountryFrom} , hereinafter referred to as the Disclosing party',
                      style: GoogleFonts.spartan(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          wordSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '\nAND\n',
                        style: GoogleFonts.spartan(
                            height: 2,
                            fontSize: 12,
                            color: Colors.black,
                            wordSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'M/s . \t\t${contractModel.userNameTo},\t\taddressed at \t\t${contractModel.userAddressTo} ,\t\t${contractModel.userLocalityTo},\t\t${contractModel.userCityTo},\t\t${contractModel.userProvinceTo},\t\t${contractModel.userCountryTo}',
                      style: GoogleFonts.spartan(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          wordSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'here in after referred to as the Receiving party collectively referred to as the "Parties".',
                      style: GoogleFonts.spartan(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          wordSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                        '\nAdditional Info : ${contractModel.contractDetail?.warning ?? ''}\n',
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center),
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
                      style: GoogleFonts.spartan(
                          fontSize: 12, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                  ]),
            ),
          ),
        ));
  }

  String getDate(ContractModel contractModel) {
    String date = contractModel.contractStartDate ?? '';
    print(date);
    final dateTime = DateTime.parse(date);
    final formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }
}
