import 'package:flutter/material.dart';
import 'package:fyp/screens/handyman/component/employer_name.dart';

import 'package:fyp/util/constant.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractorName extends StatefulWidget {
 final String title;
  const ContractorName({required this.title,Key? key}) : super(key: key);

  @override
  State<ContractorName> createState() => _ContractorNameState();
}

class _ContractorNameState extends State<ContractorName> {
  final nameController = TextEditingController();
  final myselfController = TextEditingController();
  final healthyController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
                controller: nameController,
                title: 'Enter Name',
                text: 'Enter Name of Contractor',
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
                        final data = nameController.text;
                        final myself = myselfController.text;
                        final healthy = healthyController.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EmployerName(title: 'Employer Name',)));
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


