import 'package:flutter/material.dart';
import 'package:fyp/model/contract_create_model.dart';
import 'package:fyp/screens/agreement_screen/agreemenet_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractScreen extends StatelessWidget {
  static const String routeName = '/ContractScreen';

  const ContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose",
              style: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "your licit-agreement",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ContractCreateModel.contract.length,
                  itemBuilder: (context, index) {
                    final contract = ContractCreateModel.contract[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AgreementScreen.routeName,
                            arguments: contract);
                      },
                      child: SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: CustomCard(
                            title: contract.name,
                            description: contract.description,
                            iconData: contract.iconUrl,
                            time: contract.time),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final String time;
  const CustomCard({
    Key? key,
    required this.title,
    required this.description,
    required this.iconData,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey.shade400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(iconData),
                Row(
                  children: [
                    const Icon(Icons.timer_rounded),
                    const SizedBox(width: 10),
                    Text(time,
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.w300)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
