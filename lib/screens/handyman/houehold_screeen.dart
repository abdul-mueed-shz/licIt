import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/handyman/component/contractor_name.dart';
import 'package:fyp/screens/handyman/handyman_provider.dart';
import 'package:fyp/util/constant.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HouseHoldScreen extends StatelessWidget {
  static const String routeName = '/householdScreen';
  const HouseHoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HandyManProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GeneralText(title: 'HouseHold Services'),
          const SizedBox(height: 30),
          RadioListWidget(
              selectedRadioValue: provider.onChangedTimeLineRadioValue,
              title: 'Are you Contractor or your are employer ?',
              delay: 300,
              radioList: const ['I am Contractor', 'I am Employer']),
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
    final provider = context.read<HandyManProvider>();

    if (provider.selectedHandyManRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const ContractorName(
                  title: 'Contractor Name',
                )));
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

class DeleteBacKFunctionality extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final double height;
  final BuildContextCallback onTap;
  const DeleteBacKFunctionality(
      {Key? key,
      this.color = Colors.green,
      this.height = 50,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        width: 150,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
