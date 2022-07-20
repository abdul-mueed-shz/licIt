import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/handyman/component/work_due.dart';
import 'package:fyp/screens/handyman/handyman_provider.dart';

import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:fyp/widget/validator.dart';
import 'package:provider/provider.dart';

class UsingSubContractor extends StatefulWidget {
  const UsingSubContractor({Key? key}) : super(key: key);

  @override
  State<UsingSubContractor> createState() => _UsingSubContractorState();
}

class _UsingSubContractorState extends State<UsingSubContractor> {
  final usingSubContractorController = TextEditingController();

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
            RadioListWidget(
                selectedRadioValue:
                    provider.onChangedUsingSubContractorsRadioValue,
                title: 'Will Contractor be using SubContractor ?',
                delay: 300,
                radioList: const ['Yes', 'No']),
            Selector<HandyManProvider, String?>(
              selector: (context, provider) =>
                  provider.selectedUsingSubContractorRadioValue,
              builder: (context, value, child) {
                return value != null && value == 'Yes'
                    ? TitleWithTextField(
                        controller: usingSubContractorController,
                        title: 'Enter an Utilities',
                        text: 'Details / Names of Subcontractors to be used',
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
      final data = usingSubContractorController.text;
    }
    if (provider.selectedUsingSubContractorRadioValue == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkDue()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
