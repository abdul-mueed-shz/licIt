import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewTemplateScreen extends StatefulWidget {
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
  final String userProvinceTo;

  const ReviewTemplateScreen(
      {Key? key,
      required this.startDate,
      required this.endDate,
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
      required this.userProvinceTo})
      : super(key: key);

  @override
  State<ReviewTemplateScreen> createState() => _ReviewTemplateScreenState();
}

class _ReviewTemplateScreenState extends State<ReviewTemplateScreen> {
  final formDataKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
              title:
                  'This Agreement is Entered into on Date ${widget.startDate}'),
          MyTextWidget(
              title:
                  'Between M/s. ${widget.userNameFrom} ,addressed at ${widget.userAddressFrom}'),
          MyTextWidget(
              title:
                  '${widget.userLocalityFrom} ,${widget.userCityFrom},${widget.userProvinceFrom},${widget.userCountryFrom} hereinafter referred'),
          const MyTextWidget(title: 'to as the Disclosing party'),
          const Text('\n And \n'),
          MyTextWidget(
              title:
                  'M/s. ${widget.userNameTo} ,addressed at ${widget.userAddressTo} ,${widget.userLocalityTo} ,${widget.userCityTo}'),
          MyTextWidget(
              title:
                  '${widget.userProvinceTo},${widget.userCountryTo} hereinafter referred to as the'),
          MyTextWidget(
              title:
                  'Receiving party collectively ,${widget.userCountryTo} hereinafter referred to as the'),
        ],
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  final String title;
  const MyTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(fontSize: 16),
    );
  }
}
