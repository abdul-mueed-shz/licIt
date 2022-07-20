import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/component/rental_occupants.dart';

import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentalDeposit extends StatefulWidget {
  final String title;
  const RentalDeposit({required this.title, Key? key}) : super(key: key);

  @override
  State<RentalDeposit> createState() => _RentalDepositState();
}

class _RentalDepositState extends State<RentalDeposit> {
  final rentalSecurityController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    rentalSecurityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TitleWithTextField(
                controller: rentalSecurityController,
                title: 'Enter an Amount',
                text: 'Security Deposit',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            DateTimeField(
                onDateTimeChanged: provider.onSelectedDateOfSecurityChanged,
                title: 'Due date of Security Deposit',
                delay: 300),
            const SizedBox(height: 10),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.keyboard_backspace, onTap: _deleteTap),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: MyElevatedButton(
                    'Next',
                    onTap: _tap,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.delete, onTap: _deleteTap),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _tap(BuildContext context) async {
    final provider = context.read<RentalProvider>();
    if (key.currentState!.validate()) {
      final data = rentalSecurityController.text;
    }
    if (provider.selectedDateOfSecurity == null) {
      return EasyLoading.showError("Please Fill All Field");
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RentalOccupants()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
