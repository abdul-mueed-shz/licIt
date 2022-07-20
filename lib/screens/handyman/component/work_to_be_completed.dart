import 'package:flutter/material.dart';
import 'package:fyp/screens/handyman/component/employer_name.dart';
import 'package:fyp/screens/handyman/component/using_subcontrator.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';

import 'package:fyp/util/constant.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkToBeCompleted extends StatefulWidget {
  final String title;
  const WorkToBeCompleted({required this.title,Key? key}) : super(key: key);

  @override
  State<WorkToBeCompleted> createState() => _WorkToBeCompletedState();
}

class _WorkToBeCompletedState extends State<WorkToBeCompleted> {
  final workCompletedController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    workCompletedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                controller: workCompletedController,
                title: 'Give the brief description',
                text: 'Describe the work to be Completed',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),

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
                  child: MyElevatedButton(
                    'Next',
                    onTap: (_) {
                      if (key.currentState!.validate()) {
                        final data = workCompletedController.text;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const UsingSubContractor()));
                      }
                    },
                  ),
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

  void _deleteTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}


