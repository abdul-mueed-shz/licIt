import 'package:flutter/material.dart';
import 'package:fyp/util/my_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractDetailScreen extends StatefulWidget {
  final String startDate;
  final String endDate;

  final String userNameFrom;
  final String userNameTo;
  final String userAddressFrom;
  final String userAddressTo;
  final String userCityFrom;
  final String userCityTo;
  final String userCountryFrom;
  final String userCountryTo;
  final String userLocalityFrom;
  final String userLocalityTo;
  final String userProvinceFrom;
  final String warning;
  final String userProvinceTo;
  final String witness1;
  final String witness2;

  const ContractDetailScreen({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.warning,
    required this.witness1,
    required this.witness2,
    required this.userNameFrom,
    required this.userNameTo,
    required this.userAddressFrom,
    required this.userAddressTo,
    required this.userCityFrom,
    required this.userCityTo,
    required this.userCountryFrom,
    required this.userCountryTo,
    required this.userLocalityFrom,
    required this.userLocalityTo,
    required this.userProvinceFrom,
    required this.userProvinceTo,
  }) : super(key: key);

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Licit Agreement",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                widget.warning.isNotEmpty
                    ? Text(
                        widget.warning,
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.8),
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      const MyTextWidget(
                        title: 'This Agreement is Entered into on',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                        title: 'Start Date',
                        content: widget.startDate.formattedDate,
                      ),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Between M/s', content: widget.userNameFrom),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'addressed at',
                          content: widget.userAddressFrom),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Locality ', content: widget.userLocalityFrom),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'City ', content: widget.userCityFrom),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Province ', content: widget.userProvinceFrom),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Country ', content: widget.userCountryFrom),
                      const SizedBox(height: 5),
                      const MyTextWidget(
                          title:
                              'here in after referred to as the Disclosing party'),
                      Text(
                        '',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ContractRichTextSpan(
                        title: 'End Date',
                        content: widget.endDate.formattedDate,
                      ),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Between M/s', content: widget.userNameTo),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'addressed at', content: widget.userAddressTo),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Locality ', content: widget.userLocalityTo),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'City ', content: widget.userCityTo),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Province ', content: widget.userProvinceTo),
                      const SizedBox(height: 5),
                      ContractRichTextSpan(
                          title: 'Country ', content: widget.userCountryTo),
                      const SizedBox(height: 5),
                      const MyTextWidget(
                          title:
                              'Receiving party collectively  here in after referred to as the'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(widget.witness1.isNotEmpty
                              ? widget.witness1
                              : ''),
                          Text(
                              widget.witness2.isNotEmpty ? widget.witness2 : '')
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  final String title;
  final TextAlign textAlign;

  const MyTextWidget(
      {Key? key, required this.title, this.textAlign = TextAlign.justify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.lato(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow),
    );
  }
}

class ContractRichTextSpan extends StatelessWidget {
  final String title;
  final String content;

  const ContractRichTextSpan(
      {Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: title,
                style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ])),
        ),
        Expanded(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: content,
                style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ])),
        ),
      ],
    );
  }
}
