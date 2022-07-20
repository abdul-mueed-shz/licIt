import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/component/rental_deposite.dart';

import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentalDetails extends StatefulWidget {
  final String title;
  const RentalDetails({required this.title, Key? key}) : super(key: key);

  @override
  State<RentalDetails> createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {
  final rentalAmountController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    rentalAmountController.dispose();

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
                controller: rentalAmountController,
                title: 'Enter Data',
                text: 'Enter Rental Amount',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            DateTimeField(
                onDateTimeChanged: provider.onSelectedStartChanged,
                title: 'Date Rental Begins',
                delay: 300),
            const SizedBox(height: 10),
            RadioListWidget(
                selectedRadioValue: provider.onChangedRentalPaymenRadioValue,
                title: 'Due Date Of Rental Payments',
                delay: 300,
                radioList: const [
                  'First day of each rental period ',
                  'Total rental amount due up front',
                  'Total rental amount due at end of rental period ',
                  'other'
                ]),
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
      final data = rentalAmountController.text;
    }
    if (provider.selectedStartDate == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    if (provider.selectedRentalPaymentRadioValue == null) {
      return EasyLoading.showError("Please Select Option");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const RentalDeposit(
                  title: 'Rental Deposit',
                )));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
