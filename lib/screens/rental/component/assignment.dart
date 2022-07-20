import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/component/utilities.dart';
import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:provider/provider.dart';

import '../../../widget/gernal_text.dart';
import '../../promise_agreement/component/time_line.dart';


class Assignment extends StatelessWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GeneralText(title: 'Rental Agreement'),
          const SizedBox(height: 30),
          RadioListWidget(
              selectedRadioValue: provider.onChangedAssignmentRadioValue,
              title: 'Subletting or Assignment allowed ?',
              delay: 300,
              radioList: const ['Yes with Permission', 'No']),
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

    if (provider.selectedAssignmentRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Utilities()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
