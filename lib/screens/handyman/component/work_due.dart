import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/handyman/component/final_approval.dart';
import 'package:fyp/screens/handyman/handyman_provider.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkDue extends StatelessWidget {
  const WorkDue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HandyManProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GeneralText(title: 'WorkDue'),
          const SizedBox(height: 30),
          DateTimeField(
              onDateTimeChanged: provider.onSelectedStartChanged,
              title: 'When is the Completed Work due :',
              delay: 300),
          const SizedBox(height: 30),
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

    if (provider.selectedStartDate == null) {
      return EasyLoading.showError("Please Fill All Field");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const FinalApproval(title: 'Final approval')));
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
