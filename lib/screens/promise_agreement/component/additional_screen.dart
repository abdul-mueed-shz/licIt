import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/promise_agreement/component/penalties_screen.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:provider/provider.dart';

class AdditionalScreen extends StatefulWidget {
  static const String routeName = '/AdditionalScreen';

  const AdditionalScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {
  @override
  void initState() {
    final provider = Provider.of<PromiseProvider>(context, listen: false);
    final pref = storage.contract;
    if (pref?.id != null &&
        pref?.contractDetail?.additionalConditionsRadio != null) {
      provider.setAdditionalValue();
    }
    super.initState();
  }

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
          return Consumer<PromiseProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Consumer<PromiseProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GeneralText(title: 'Additional conditions'),
                        const SizedBox(height: 30),
                        RadioListWidget(
                          selectedRadioValue:
                              provider.onChangedAdditionalRadioValue,
                          title: 'Any Additional conditions ?',
                          value: provider.selectedAdditionalRadioValue,
                          delay: 300,
                          radioList: const ['Yes', 'No'],
                        ),
                        provider.selectedAdditionalRadioValue != null &&
                                provider.selectedAdditionalRadioValue == 'Yes'
                            ? TitleWithTextField(
                                controller: provider.conditionController,
                                title: 'Additional conditions',
                                text: 'Conditions')
                            : const SizedBox(),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: DeleteBacKFunctionality(
                                  iconData: Icons.keyboard_backspace,
                                  onTap: _backward),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              flex: 5,
                              child:
                                  MyElevatedButton('Next Button', onTap: _tap),
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
            },
          );
        });
  }

  void _tap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();

    if (provider.selectedAdditionalRadioValue == null) {
      return EasyLoading.showError("Please Fill all field");
    }
    if (provider.selectedAdditionalRadioValue == 'Yes' &&
        provider.conditionController.text.isEmpty) {
      return EasyLoading.showError("Please Fill all Field");
    }

    provider.addAdditionalScreenField();
    final pref = storage.contract;

    if (pref?.contractDetail?.violateContractRadio == null) {
      provider.haveController.clear();
      provider.haveController.clear();
      provider.selectedPenaltiesRadioValue = null;
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PenaltiesScreen()));
  }

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _backward(BuildContext context) {
    Navigator.of(context).pop();
  }
}
