import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/rental/rental_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:fyp/widget/validator.dart';
import 'package:provider/provider.dart';

import '../../../widget/gernal_text.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  final descriptionOfUtilitiesController = TextEditingController();

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
                selectedRadioValue: provider.onChangedUtilitiesRadioValue,
                title: 'Are Utilities include ?',
                delay: 300,
                radioList: const ['Yes', 'No']),
            Selector<RentalProvider, String?>(
              selector: (context, provider) =>
                  provider.selectedUtilitiesRadioValue,
              builder: (context, value, child) {
                return value != null && value == 'Yes'
                    ? TitleWithTextField(
                        controller: descriptionOfUtilitiesController,
                        title: 'Enter an Utilities',
                        text: 'Enter description of utilities to be include',
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
      final data = descriptionOfUtilitiesController.text;
    }
    if (provider.selectedUtilitiesRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => const Assignment()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
