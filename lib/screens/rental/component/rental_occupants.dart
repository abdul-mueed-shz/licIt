import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/component/assignment.dart';

import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:fyp/widget/validator.dart';
import 'package:provider/provider.dart';

import '../../../widget/gernal_text.dart';

class RentalOccupants extends StatefulWidget {
  const RentalOccupants({Key? key}) : super(key: key);

  @override
  State<RentalOccupants> createState() => _RentalOccupantsState();
}

class _RentalOccupantsState extends State<RentalOccupants> {
  final nameOfPermittedController = TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GeneralText(title: 'Rental Agreement'),
            const SizedBox(height: 30),
            RadioListWidget(
                selectedRadioValue: provider.onChangedRentalOccupantRadioValue,
                title: 'Are there other occupants ?',
                delay: 300,
                radioList: const ['Yes', 'No']),
            Selector<RentalProvider, String?>(
              selector: (context, provider) =>
                  provider.selectedRentalOccupantRadioValue,
              builder: (context, value, child) {
                return value != null && value == 'Yes'
                    ? TitleWithTextField(
                        controller: nameOfPermittedController,
                        title: 'Enter an names',
                        text: 'Enter names of permitted Occupants',
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
    final provider = context.read<RentalProvider>();
    if (key.currentState!.validate()) {
      final data = nameOfPermittedController.text;
    }
    if (provider.selectedRentalOccupantRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Assignment()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
