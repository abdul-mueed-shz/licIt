import 'package:flutter/material.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/review_template_screen/review_template_dart.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractDetailScreen extends StatefulWidget {
  final String reviewImage;
  final String requestImage;
  final ReviewModel? reviewModel;
  final ContractModel contractModel;
  final String witness1;
  final String witness2;
  final bool witness1status;
  final bool witness2status;
  final String? imageWitness1;
  final String? imageWitness2;
  final String witness1Name;
  final String witness2Name;

  const ContractDetailScreen({
    Key? key,
    required this.witness1,
    required this.witness2,
    required this.witness1status,
    required this.witness2status,
    required this.reviewImage,
    required this.requestImage,
    this.reviewModel,
    required this.contractModel,
    this.imageWitness1,
    this.imageWitness2,
    required this.witness1Name,
    required this.witness2Name,
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
                if (widget.contractModel.contractStatus == 'Promise')
                  MyPreviewScreen(
                      witness1Name: widget.witness1Name,
                      witness2Name: widget.witness2Name,
                      contractModel: widget.contractModel,
                      reviewImage: widget.reviewImage,
                      userNameFrom: widget.reviewModel?.reviewName ?? '',
                      requestImage: widget.requestImage,
                      userNameTo: widget.reviewModel?.requestName ?? '',
                      witness2: widget.witness2,
                      reviewModel: widget.reviewModel,
                      witness1status: widget.witness2status,
                      witness1: widget.witness1,
                      imageWitness1: widget.imageWitness1,
                      imageWitness2: widget.imageWitness2,
                      witness2status: widget.witness1status),
                if (widget.contractModel.contractStatus == 'Rental')
                  MyRentalView(
                      contractModel: widget.contractModel,
                      witness1Name: widget.witness1Name,
                      witness2Name: widget.witness2Name,
                      reviewImage: widget.reviewImage,
                      userNameFrom: widget.reviewModel?.reviewName ?? '',
                      requestImage: widget.requestImage,
                      userNameTo: widget.reviewModel?.requestName ?? '',
                      witness2: widget.witness2,
                      reviewModel: widget.reviewModel,
                      witness1status: widget.witness2status,
                      imageWitness1: widget.imageWitness1,
                      imageWitness2: widget.imageWitness2,
                      witness1: widget.witness1,
                      witness2status: widget.witness1status),
                if (widget.contractModel.contractStatus == 'Handy')
                  MyHandyPreview(
                      contractModel: widget.contractModel,
                      reviewImage: widget.reviewImage,
                      witness1Name: widget.witness1Name,
                      witness2Name: widget.witness2Name,
                      userNameFrom: widget.reviewModel?.reviewName ?? '',
                      requestImage: widget.requestImage,
                      userNameTo: widget.reviewModel?.requestName ?? '',
                      witness2: widget.witness2,
                      imageWitness1: widget.imageWitness1,
                      imageWitness2: widget.imageWitness2,
                      reviewModel: widget.reviewModel,
                      witness1status: widget.witness2status,
                      witness1: widget.witness1,
                      witness2status: widget.witness1status)
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
