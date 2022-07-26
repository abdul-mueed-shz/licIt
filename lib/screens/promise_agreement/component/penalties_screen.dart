import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/util/my_slide_transition.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:provider/provider.dart';

import '../../../widget/gernal_text.dart';

class PenaltiesScreen extends StatefulWidget {
  static const String routeName = '/PenaltiesScreen';

  const PenaltiesScreen({Key? key}) : super(key: key);

  @override
  State<PenaltiesScreen> createState() => _PenaltiesScreenState();
}

class _PenaltiesScreenState extends State<PenaltiesScreen> {
  @override
  void initState() {
    final provider = Provider.of<PromiseProvider>(context, listen: false);
    final pref = storage.contract;
    if (pref?.contractDetail?.violateContractRadio != null) {
      provider.setPenaltyValues();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GeneralText(title: 'Penalties'),
                    const SizedBox(height: 30),
                    RadioListWidget(
                        selectedRadioValue:
                            provider.onChangedPenaltiesRadioValue,
                        title: 'If I Violate the Contract, Then',
                        delay: 300,
                        value: provider.selectedPenaltiesRadioValue,
                        radioList: const [
                          'Pay a Monetary penalty',
                          'Have to do',
                          'Renegotiate',
                          'Nothing'
                        ]),
                    const SizedBox(height: 40),
                    PenaltiesChecker(
                      payController: provider.penaltyController,
                      haveController: provider.haveController,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: DeleteBacKFunctionality(
                              iconData: Icons.keyboard_backspace, onTap: _back),
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
            },
          );
        });
  }

  void _tap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();
    if (provider.selectedPenaltiesRadioValue == null) {
      return EasyLoading.showError("Please Select any field");
    }
    if (provider.selectedPenaltiesRadioValue == 'Pay a Monetary penalty' &&
        provider.penaltyController.text.isEmpty) {
      return EasyLoading.showError("Please fill all required field");
    }
    if (provider.selectedPenaltiesRadioValue == 'Have to do' &&
        provider.haveController.text.isEmpty) {
      return EasyLoading.showError("Please fill all required field");
    }
    provider.updatePenaltyField();

    Navigator.pushNamed(context, GeneralTemplate.routeName);
  }

  void _deleteTap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();
    final isFieldEmpty = await provider.deleteStatus(context);
    isFieldEmpty
        ? Navigator.of(context).popUntil(ModalRoute.withName('/TabScreen'))
        : Navigator.pop(context);
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class PenaltiesChecker extends StatelessWidget {
  final TextEditingController payController;
  final TextEditingController haveController;

  const PenaltiesChecker(
      {Key? key, required this.payController, required this.haveController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PromiseProvider>(
      builder: (context, provider, child) {
        return MySlideTransition(
          child: Column(
            children: [
              provider.selectedPenaltiesRadioValue == 'Pay a Monetary penalty'
                  ? TitleWithTextField(
                      controller: payController,
                      text: 'Enter Amount to pay',
                      inputType: TextInputType.number,
                      title: 'e.g \$1000 for my friend')
                  : const SizedBox(),
              provider.selectedPenaltiesRadioValue == 'Have to do'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GeneralText(
                            size: 19,
                            title: 'What to do :',
                            fontWeight: FontWeight.bold),
                        const SizedBox(height: 20),
                        TitleWithTextField(
                            controller: haveController,
                            fontWeight: FontWeight.normal,
                            size: 14,
                            text:
                                'Describe What ever you should to do when you violate Contract :',
                            title: 'e.g Clean backyard'),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
