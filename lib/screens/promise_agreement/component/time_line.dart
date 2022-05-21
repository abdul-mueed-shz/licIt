import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/util/pref.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/date_time_field.dart';
import 'package:fyp/widget/radio_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimeLineScreen extends StatefulWidget {
  static const String routeName = '/TimeLineScreen';

  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PromiseProvider>(context, listen: false);
    final pref = Prefs.instance.contract;
    if (pref?.contractDetail?.executionDate != null &&
        pref?.contractDetail?.isCompletionRadio != null) {
      provider.timeLineClear = true;
    }
    if (pref?.id != null &&
        pref?.contractDetail?.executionDate != null &&
        pref?.contractDetail?.isCompletionRadio != null &&
        provider.timeLineClear) {
      provider.setTimeLineUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  selectedRadioValue: provider.onChangedTimeLineRadioValue,
                  title: 'Is Completion indefinitely',
                  delay: 300,
                  value: provider.selectedTimeLineRadioValue,
                  radioList: const ['Yes', 'No']),
              Selector<PromiseProvider, String?>(
                selector: (context, provider) =>
                    provider.selectedTimeLineRadioValue,
                builder: (context, value, child) {
                  return value != null && value == 'No'
                      ? DateTimeField(
                          onDateTimeChanged: provider.onSelectedEndChanged,
                          title: 'End Date of Completion',
                          defaultValue: provider.selectedEndDate,
                          delay: 300,
                        )
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
          );
        },
      ),
    );
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

    final pref = Prefs.instance.contract;
    if (pref?.contractDetail?.additionalConditionsRadio == null &&
        pref?.contractDetail?.additionalCondition == null) {
      provider.additionalClear = false;
      provider.selectedAdditionalRadioValue = null;
      provider.conditionController.text = '';
    }
    context.read<PromiseProvider>().updateTimeLineField();
    if (pref?.contractDetail?.additionalCondition == null &&
        !provider.additionalClear) {
      provider.selectedAdditionalRadioValue = null;
      provider.conditionController.clear();
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AdditionalScreen()));
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
