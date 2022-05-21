import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/component/description.dart';
import 'package:fyp/screens/rental/rental_agreement.dart';
import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentCategory extends StatelessWidget {
  const RentCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GeneralText(title: 'Rental Category'),
          const SizedBox(height: 30),
          CheckBoxWidget(
            selectedCheckedValue: provider.onChangedCheckBoxValue,
            title: 'Rental estate,property,living accommodations',
            delay: 300,
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
    );
  }

  void _tap(BuildContext context) async {
    final provider = context.read<RentalProvider>();

    if (provider.selectedRentalCategoryValue == null ||
        provider.selectedRentalCategoryValue == false) {
      return EasyLoading.showError("Please Fill All Field");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const Description(title: 'Rental Agreement')));
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
