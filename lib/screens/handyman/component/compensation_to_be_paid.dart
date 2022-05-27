import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/handyman/handyman_provider.dart';
import 'package:fyp/screens/rental/rental_agreement.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompensationToBePaid extends StatefulWidget {
  const CompensationToBePaid({Key? key}) : super(key: key);

  @override
  State<CompensationToBePaid> createState() => _CompensationToBePaidState();
}

class _CompensationToBePaidState extends State<CompensationToBePaid> {
  final compensationPaidController = TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = context.read<HandyManProvider>();
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const GeneralText(title: 'Compensation To Be Paid'),
            RadioListWidget(
                selectedRadioValue:
                    provider.onChangedCompensationPaidRadioValue,
                title: 'How is Compensation to be paid',
                delay: 300,
                radioList: const [
                  'Lump Sum upon delivery',
                  'Payment upfront',
                  'Other'
                ]),
            Selector<HandyManProvider, String?>(
              selector: (context, provider) =>
                  provider.selectedCompensationPaidRadioValue,
              builder: (context, value, child) {
                return value != null && value == 'Other'
                    ? TitleWithTextField(
                        controller: compensationPaidController,
                        title: 'e.g 50% upfront + 50 % upon delivery',
                        text: 'Details',
                        validator: Validator.basicValidator)
                    : const SizedBox();
              },
            ),
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
                  child: MyElevatedButton('Next Button', onTap: _tap),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.delete, onTap: _deleteTap),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _tap(BuildContext context) async {
    final provider = context.read<HandyManProvider>();
    if (key.currentState!.validate()) {
      final data = compensationPaidController.text;
    }
    if (provider.selectedCompensationPaidRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class GeneralText extends StatelessWidget {
  final String title;
  final double size;
  final TextAlign? align;
  final FontWeight fontWeight;

  const GeneralText(
      {Key? key,
      this.fontWeight = FontWeight.normal,
      required this.title,
      this.size = 30,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: GoogleFonts.lato(fontSize: size, fontWeight: fontWeight),
    );
  }
}
