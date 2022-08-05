import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_create_model.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/job_agreement/job_provider.dart';
import 'package:fyp/screens/rent_agreement/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgreementScreen extends StatefulWidget {
  static const String routeName = '/AgreementScreen';

  const AgreementScreen({Key? key}) : super(key: key);

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    final modal =
        ModalRoute.of(context)!.settings.arguments as ContractCreateModel;
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Icon(modal.iconUrl, size: 120)),
          const SizedBox(height: 30),
          Text(
            modal.name,
            style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            modal.title,
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(fontSize: 16, color: Colors.grey),
          ),
          const Spacer(),
          MyElevatedButton('Next', onTap: (_) async {
            await storage.removeUser();
            context.read<PromiseProvider>().clearAllData();
            context.read<JobProvider>().clearAllJobData();
            context.read<RentalProvider>().clearAllData();
            Navigator.pushNamed(context, modal.routeName,
                arguments: modal.name);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
