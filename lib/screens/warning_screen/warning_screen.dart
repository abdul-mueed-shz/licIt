import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:fyp/widget/button.dart';

class WarningScreen extends StatefulWidget {
  static const String routeName = '/WarningScreen';
  const WarningScreen({Key? key}) : super(key: key);

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
                color: Colors.green,
              ),
              child: const Text(
                'LicIt.',
                style: TextStyle(
                  color: Colors.white, fontSize: 60,
                  fontWeight: FontWeight.bold,

                  //fontFamily:,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              child: TextFormField(
                controller: controller,
                maxLines: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter additional Information',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  label: const Text(
                      'Additional Information Any Information Enter'),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            child: Row(
              children: [
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.keyboard_backspace, onTap: _deleteTap),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: MyElevatedButton('Next', onTap: _tap),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.delete, onTap: _deleteTap),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteTap(BuildContext context) {}

  void _tap(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await contractRepository.update(storage.contract?.id ?? '3123456789123', {
        'contractDetail.warning': controller.text.trim(),
        'savedPlace': WarningScreen.routeName,
      });
    }
    final contractDataModel =
        await contractRepository.get(storage.contract?.id ?? '3123456789123');
    if (contractDataModel?.contractDetail?.showSendOption == true) return;
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  @override
  void initState() {
    final pref = storage.contract;
    if (pref?.contractDetail?.warning != null) {
      controller.text = pref?.contractDetail?.warning ?? '';
    }
    super.initState();
  }
}
