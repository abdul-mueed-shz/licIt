import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:provider/provider.dart';

import '../../../widget/gernal_text.dart';

class TimeLineScreen extends StatefulWidget {
  static const String routeName = '/TimeLineScreen';

  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(storage.id)
            .collection("contract")
            .doc(storage.contract?.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!.data();
            final contractData = ContractModel.fromJson(data!);
            storage.setContract(contractData);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Consumer<PromiseProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GeneralText(title: 'TimeLine'),
                    const SizedBox(height: 30),
                    DateTimeField(
                        onDateTimeChanged: provider.onSelectedStartChanged,
                        title: 'Start Date of Execution',
                        defaultValue: provider.selectedStartDate,
                        delay: 300),
                    const SizedBox(height: 30),
                    RadioListWidget(
                        selectedRadioValue:
                            provider.onChangedTimeLineRadioValue,
                        title: 'Is Completion indefinitely',
                        delay: 300,
                        value: provider.selectedTimeLineRadioValue,
                        radioList: const ['Yes', 'No']),
                    provider.selectedTimeLineRadioValue != null &&
                            provider.selectedTimeLineRadioValue == 'No'
                        ? DateTimeField(
                            onDateTimeChanged: provider.onSelectedEndChanged,
                            title: 'End Date of Completion',
                            defaultValue: provider.selectedEndDate,
                            delay: 300,
                          )
                        : const SizedBox(),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: DeleteBacKFunctionality(
                              iconData: Icons.keyboard_backspace,
                              onTap: _backButton),
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
                );
              },
            ),
          );
        });
  }

  void _tap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();

    if (provider.selectedTimeLineRadioValue == null ||
        provider.selectedStartDate == null) {
      return EasyLoading.showError("Please Fill All Field");
    }
    if (provider.selectedTimeLineRadioValue == 'No' &&
        provider.selectedEndDate == null) {
      return EasyLoading.showError("Please Select End Date");
    }
    provider.updateTimeLineField();

    final pref = storage.contract;
    if (pref?.contractDetail?.additionalConditionsRadio == null &&
        pref?.contractDetail?.additionalCondition == null) {
      provider.selectedAdditionalRadioValue = null;
      provider.conditionController.clear();
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AdditionalScreen()));
  }

  void _backButton(BuildContext context) => Navigator.pop(context);
  void _deleteTap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();
    final isFieldEmpty = await provider.deleteStatus(context);
    isFieldEmpty
        ? Navigator.of(context).popUntil(ModalRoute.withName('/TabScreen'))
        : Navigator.pop(context);
  }

  @override
  void initState() {
    final provider = Provider.of<PromiseProvider>(context, listen: false);
    final pref = storage.contract;
    if (pref?.id != null &&
        pref?.contractDetail?.executionDate != null &&
        pref?.contractDetail?.isCompletionRadio != null) {
      provider.setTimeLineUpdate();
    }
    super.initState();
  }
}
