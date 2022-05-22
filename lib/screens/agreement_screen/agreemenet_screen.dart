import 'package:flutter/material.dart';
import 'package:fyp/model/contract_create_model.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/util/pref.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgreementScreen extends StatelessWidget {
  static const String routeName = '/AgreementScreen';

  const AgreementScreen({Key? key}) : super(key: key);

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
            "An official Pledge to myself with a Signature An official Pledge to myself with a Signature An official Pledge to myself with a Signature An official Pledge to myself with a Signature An official Pledge to myself with a Signature An official Pledge to myself with a Signature",
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(fontSize: 16),
          ),
          const Spacer(),
          MyElevatedButton('Next Button', onTap: (_) {
            Prefs.instance.removeUser();
            context.read<PromiseProvider>().clearAllData();
            Navigator.pushNamed(context, modal.routeName,
                arguments: modal.name);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
