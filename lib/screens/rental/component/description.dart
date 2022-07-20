import 'package:flutter/material.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/screens/rental/component/rental_details.dart';

import 'package:fyp/util/constant.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/common_widget.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatefulWidget {
  final String title;
  const Description({required this.title,Key? key}) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final typeOfPropertyController = TextEditingController();
  final locationOfPropertyController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    typeOfPropertyController.dispose();
    locationOfPropertyController.dispose();
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
                controller: typeOfPropertyController,
                title: 'House,Apartment,room,other(enter other)',
                text: 'Describe the type of property',
                validator: Validator.basicValidator),
            const SizedBox(height: 10),
            TitleWithTextField(
                controller: locationOfPropertyController,
                title: 'Enter address or description of location',
                text: 'Enter Location of property',
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
                        final data = typeOfPropertyController.text;
                        final myself = locationOfPropertyController.text;

                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const RentalDetails(title:'Rental Details')));

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


