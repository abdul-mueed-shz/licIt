import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/screens/home_screen/home_screen.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/util/constant.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PromiseAgreement extends StatefulWidget {
  final String title;

  static const String routeName = '/PromiseAgreement';

  const PromiseAgreement({Key? key, this.title = 'Promise'}) : super(key: key);

  @override
  State<PromiseAgreement> createState() => _PromiseAgreementState();
}

class _PromiseAgreementState extends State<PromiseAgreement> {
  @override
  void initState() {
    final provider = Provider.of<PromiseProvider>(context, listen: false);
    final contractModel = storage.contract;

    if (contractModel != null && contractModel.id.isNotEmpty) {
      provider.setPromiseValueDefault();
    }

    super.initState();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PromiseProvider>();
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TitleWithTextField(
                controller: provider.nameController,
                title: 'e.g John Dou',
                text: 'I',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            TitleWithTextField(
                controller: provider.myselfController,
                title: 'e.g Quit Smoking',
                text: 'Make the Contract with myself that:',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            TitleWithTextField(
                controller: provider.healthyController,
                title: 'e.g be Healthy',
                text: 'I am Doing this For :',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.keyboard_backspace, onTap: _backButton),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: MyElevatedButton('Next', onTap: (_) async {
                    if (key.currentState!.validate()) {
                      await provider.addPromiseAgreementData(widget.title,
                          TimeLineScreen.routeName, Status.draft.value);
                      final pref = storage.contract;
                      if (pref?.contractDetail?.isCompletionRadio == null &&
                          pref?.contractDetail?.executionDate == null) {
                        provider.clearTimeLineField();
                      }
                      Navigator.pushNamed(context, TimeLineScreen.routeName);
                    }
                  }),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DeleteBacKFunctionality(
                      iconData: Icons.delete, onTap: _deleteTap),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _deleteTap(BuildContext context) async {
    final provider = context.read<PromiseProvider>();
   final isFieldEmpty= await provider.deleteStatus(context);
    isFieldEmpty ?  Navigator.of(context).popUntil(ModalRoute.withName('/TabScreen')): Navigator.pop(context);
  }
  void _backButton(BuildContext context)  =>
     Navigator.pop(context);

}



enum Status { pending, active, delete, rejected, draft }

extension StatusValue on Status {
  String get value {
    switch (this) {
      case Status.active:
        return 'Active';
      case Status.pending:
        return 'Pending';
      case Status.delete:
        return 'Delete';
      case Status.rejected:
        return 'Rejected';
      case Status.draft:
        return 'Draft';
    }
  }
}
