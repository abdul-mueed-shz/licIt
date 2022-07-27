import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/review_template_screen/pdf.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:fyp/util/constant.dart';
import 'package:fyp/util/my_extensions.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewTemplateScreen extends StatefulWidget {
  final String startDate;
  final ContractModel contractModel;
  final bool isShowReviewButton;
  final String contractID;
  final String? contractName;
  final String endDate;
  final String reviewImage;
  final String requestImage;
  final bool witnessShow;
  final String? witness1Id;
  final String? witness2Id;
  final String userNameFrom;
  final String userNameTo;
  final String userAddressFrom;
  final String userAddressTo;
  final String userCityFrom;
  final String userCityTo;
  final String receiverRequestId;
  final String userCountryFrom;
  final String userCountryTo;
  final String userLocalityFrom;
  final String userLocalityTo;
  final String userProvinceFrom;
  final String warning;
  final bool witnessStatus1;
  final bool witnessStatus2;
  final String userProvinceTo;
  final String reviewRequestID;
  final String selectedStatus;

  const ReviewTemplateScreen({
    Key? key,
    required this.startDate,
    this.isShowReviewButton = false,
    this.witnessShow = false,
    required this.contractModel,
    this.witnessStatus1 = false,
    this.witnessStatus2 = false,
    required this.endDate,
    required this.warning,
    required this.reviewRequestID,
    required this.receiverRequestId,
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
    required this.contractID,
    required this.contractName,
    this.selectedStatus = 'review',
    this.witness1Id,
    this.witness2Id,
    required this.reviewImage,
    required this.requestImage,
  }) : super(key: key);

  @override
  State<ReviewTemplateScreen> createState() => _ReviewTemplateScreenState();
}

class _ReviewTemplateScreenState extends State<ReviewTemplateScreen> {
  final formDataKey = GlobalKey<FormState>();
  bool check = false;
  bool isOnTab = true;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentID = storage.id ?? '3123456789123';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                final pdfFile = await PdfApi.generateCenteredText(
                    widget.startDate.formattedDate,
                    widget.contractID,
                    widget.contractName,
                    widget.endDate,
                    widget.reviewImage,
                    widget.requestImage,
                    widget.witnessShow,
                    widget.witness1Id,
                    widget.witness2Id,
                    widget.userNameFrom,
                    widget.userNameTo,
                    widget.userAddressFrom,
                    widget.userAddressTo,
                    widget.userCityFrom,
                    widget.userCityTo,
                    widget.receiverRequestId,
                    widget.userCountryFrom,
                    widget.userCountryTo,
                    widget.userLocalityFrom,
                    widget.userLocalityTo,
                    widget.userProvinceFrom,
                    widget.warning,
                    widget.witnessStatus1,
                    widget.witnessStatus2,
                    widget.userProvinceTo,
                    widget.reviewRequestID,
                    widget.selectedStatus);
                PdfApi.openFile(pdfFile);
              },
              icon: const Icon(
                Icons.preview,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Consumer<PromiseProvider>(
              builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.contractModel.contractStatus == 'Promise')
                      MyPreviewScreen(contractModel: widget.contractModel),
                    if (widget.contractModel.contractStatus == 'Handy')
                      MyHandyPreview(contractModel: widget.contractModel),
                    const SizedBox(height: 20),
                    if (widget.isShowReviewButton)
                      Text(
                        "Change Are Requested To Contract User",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    if (currentID == widget.receiverRequestId &&
                        provider.isShow == false &&
                        widget.witnessShow == false &&
                        widget.selectedStatus == 'review')
                      isReviewBack(),
                    if (widget.witnessShow)
                      MyElevatedButton('Click to add Witness', onTap: (_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                    witness: true, id: widget.contractID)));
                      }),
                    if (widget.witnessShow == false &&
                            !widget.witnessStatus1 &&
                            widget.selectedStatus == 'signed' ||
                        widget.witnessShow == false &&
                            !widget.witnessStatus2 &&
                            widget.selectedStatus == 'signed')
                      MyElevatedButton('Click to Signed', onTap: _signedTap),
                    const SizedBox(height: 10),
                    if (widget.witnessShow == false &&
                            !widget.witnessStatus1 &&
                            widget.selectedStatus == 'signed' ||
                        widget.witnessShow == false &&
                            !widget.witnessStatus2 &&
                            widget.selectedStatus == 'signed')
                      MyElevatedButton('Reject', onTap: _rejectWitness)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget isReviewBack() {
    if (check) {
      return Column(
        children: [
          Form(
            key: formDataKey,
            child: CommentBox(
              isOnTab: isOnTab,
              controller: controller,
              onSend: (context) async {
                if (formDataKey.currentState!.validate() && isOnTab) {
                  if (controller.text.isEmpty) {
                    return EasyLoading.showError('Please Enter Comment');
                  }
                  setState(() => isOnTab = false);
                  final data = controller.text.trim();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.reviewRequestID)
                      .collection('contract')
                      .doc(widget.contractID)
                      .update({
                    'isReviewState': true,
                  });
                  final userData =
                      await userRepository.get(widget.reviewRequestID);
                  final user2 =
                      await userRepository.get(storage.id ?? '3123456789123');
                  final commentModel = CommentModel(
                      commentName: userData?.name ?? '', comment: data);
                  await userRepository.update(widget.reviewRequestID, {
                    'comments': FieldValue.arrayUnion([commentModel.toJson()])
                  });
                  context.read<PromiseProvider>().send(
                      userData?.token ?? '',
                      'Changes Required $data',
                      '${user2?.name ?? ''} comment on contract');
                  setState(() => check = false);
                  controller.clear();
                  EasyLoading.showSuccess('Your Message have been send');

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() => isOnTab = true);
                  });
                } else {
                  return EasyLoading.showError("Please Enter Comment");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: MyElevatedButton('back', onTap: _onBack),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isShowReviewButton
              ? const SizedBox()
              : Expanded(
                  child: MyElevatedButton(
                    'Signed',
                    onTap: (context) async {
                      final update = {
                        'user2Signed': true,
                      };
                      await FirebaseFirestore.instance
                          .collection('reviews')
                          .doc(widget.contractID)
                          .update(update);
                      await userRepository.update(
                          widget.reviewRequestID, {'status': 'witness'});
                      await userRepository.update(
                          widget.receiverRequestId, {'status': 'witness'});
                      context.read<PromiseProvider>().signed();
                    },
                  ),
                ),
          const SizedBox(width: 7),
          Expanded(
              child:
                  MyElevatedButton('Send Back to Review', onTap: _onBackReview))
        ],
      );
    }
  }

  void _onBackReview(BuildContext context) {
    setState(() => check = true);
  }

  void _onBack(BuildContext context) {
    setState(() => check = false);
  }

  void _signedTap(BuildContext context) async {
    final reviewContract = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.reviewRequestID)
        .collection('contract')
        .doc(widget.contractID)
        .get();
    final review = reviewContract.data() ?? {};
    if (review.isEmpty) {
      return EasyLoading.showInfo('Somethings Happens');
    }
    final contractData = ContractModel.fromJson(review);
    if (!widget.witnessStatus1 &&
        contractData.contractDetail?.witness1?.witnessSigned == false) {
      final myReview = await FirebaseFirestore.instance
          .collection('reviews')
          .doc(widget.contractID)
          .get();
      final reviewModel = myReview.data() ?? {};
      final myReviewModel = ReviewModel.fromJson(reviewModel);
      final reviewUser = await userRepository.get(storage.id ?? '');
      final requestUserList = reviewUser?.signedWitness ?? [];
      final model = requestUserList
          .where((element) => element.contractID == myReviewModel.contractID)
          .toList()
          .first;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(storage.id)
          .update({
        'signedWitness': FieldValue.arrayRemove([model.toJson()])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.reviewRequestID)
          .collection('contract')
          .doc(widget.contractID)
          .update({
        'contractDetail.witness1.witnessSigned': true,
        'contractDetail.witness1.senderId': widget.receiverRequestId,
      });

      Navigator.of(context).pop();
    } else if (!widget.witnessStatus2 &&
        contractData.contractDetail?.witness2?.witnessSigned == false) {
      final myReview = await FirebaseFirestore.instance
          .collection('reviews')
          .doc(widget.contractID)
          .get();
      final reviewModel = myReview.data() ?? {};
      final myReviewModel = ReviewModel.fromJson(reviewModel);
      final reviewUser = await userRepository.get(storage.id ?? '');
      final requestUserList = reviewUser?.signedWitness ?? [];
      final model = requestUserList
          .where((element) => element.contractID == myReviewModel.contractID)
          .toList()
          .first;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(storage.id)
          .update({
        'signedWitness': FieldValue.arrayRemove([model.toJson()])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.reviewRequestID)
          .collection('contract')
          .doc(widget.contractID)
          .update({
        'contractDetail.witness2.witnessSigned': true,
        'contractDetail.witness1.senderId': widget.reviewRequestID,
      });

      Navigator.of(context).pop();
    }
  }

  void _rejectWitness(BuildContext context) async {
    final myReview = await FirebaseFirestore.instance
        .collection('reviews')
        .doc(widget.contractID)
        .get();
    final reviewModel = myReview.data() ?? {};
    final myReviewModel = ReviewModel.fromJson(reviewModel);

    final reviewUser = await userRepository.get(storage.id ?? '');
    final requestUserList = reviewUser?.signedWitness ?? [];

    final remove = requestUserList
        .where((element) => element.contractID == myReviewModel.contractID)
        .toList()
        .first;

    final contractModel = await FirebaseFirestore.instance
        .collection('users')
        .doc(myReviewModel.reviewRequestId)
        .collection('contract')
        .doc(myReviewModel.contractID)
        .get();
    final myContractData = contractModel.data() ?? {};
    final contractData = ContractModel.fromJson(myContractData);
    if (contractData.contractDetail?.witness1?.senderId ==
        myReviewModel.reviewRequestId) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myReviewModel.reviewRequestId)
          .collection('contract')
          .doc(myReviewModel.contractID)
          .update({
        'contractDetail.witness1': null,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myReviewModel.reviewRequestId)
          .update({
        'witnessScreenShow': FieldValue.arrayUnion([remove.toJson()])
      });
    } else if (contractData.contractDetail?.witness2?.senderId ==
        myReviewModel.receiverRequestId) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myReviewModel.reviewRequestId)
          .collection('contract')
          .doc(myReviewModel.contractID)
          .update({
        'contractDetail.witness2': null,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myReviewModel.receiverRequestId)
          .update({
        'witnessScreenShow': FieldValue.arrayUnion([remove.toJson()])
      });
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(storage.id)
        .update({
      'signedWitness': FieldValue.arrayRemove([remove.toJson()])
    });

    Navigator.of(context).pop();
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

class CommentBox extends StatelessWidget {
  final TextEditingController controller;
  final BorderRadius? inputRadius;
  final BuildContextCallback onSend;
  final bool isOnTab;

  const CommentBox(
      {Key? key,
      required this.controller,
      this.inputRadius,
      this.isOnTab = false,
      required this.onSend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      selectionHeightStyle: BoxHeightStyle.tight,
      decoration: InputDecoration(
          hintText: 'Write a Comment',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
              borderRadius: inputRadius ?? BorderRadius.circular(32)),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.send,
              color: isOnTab ? Colors.green : Colors.grey,
            ),
            onTap: () => isOnTab ? onSend(context) : 0,
          )),
      style: const TextStyle(
        color: Colors.black,
      ),
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

class MyPreviewScreen extends StatelessWidget {
  final ContractModel contractModel;
  const MyPreviewScreen({Key? key, required this.contractModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Non-Disclosure\nConfidently Agreement',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  'THIS AGREEMENT is made and executed at (${contractModel.userCityFrom}) on ( ${getDate()}) by and between ( ${contractModel.userNameFrom} ) years, ( ${contractModel.userAddressFrom} ), (${contractModel.userCityFrom}), ........... (550005), (${contractModel.userProvinceFrom} here in after jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns).',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                const Text('AND'),
                Text(
                  ' (${contractModel.userNameTo}), having permanent address ), ( ${contractModel.userAddressTo} ), (${contractModel.userCityFrom}),.... ......,(544594), (${contractModel.userProvinceFrom} hereinafter called the “Tenant", which expression shall include his legal representatives, successors and assigns).',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'WHEREAS the Landlord is the absolute owner of the Independent House situated at (R Block), (Model Town), (Lahore), ...................., (32423), (Pak), consisting of (2 bedrooms), (1 bathroom), (1 balcony),(1 car parking space), (1kitchen) and inbuilt fittings & fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises".',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Text(
                    'additional info :${contractModel.contractDetail?.warning}',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w500))
              ]),
        ),
      ),
    );
  }

  String getDate() {
    String date = contractModel.contractStartDate ?? '';
    print(date);
    final dateTime = DateTime.parse(date);
    final formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }
}

class MyHandyPreview extends StatelessWidget {
  final ContractModel contractModel;
  const MyHandyPreview({Key? key, required this.contractModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Job Offer and Employment Contract',
              textAlign: TextAlign.center,
              style: GoogleFonts.spartan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 2),
            ),
            const SizedBox(height: 28),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Private and confidential',
                  style: style,
                )),
            const SizedBox(height: 30),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  contractModel.jobUserName ?? '',
                  style: style,
                )),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${contractModel.jobAddress ?? ''}, ${contractModel.jobName ?? ''}, ${contractModel.jobCity ?? ''}, ${contractModel.jobProvince ?? ''}, ${contractModel.jobPostalCode ?? ''}, ${contractModel.jobCountry ?? ''}',
                  style: style,
                )),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topLeft,
                child: Text('Offer of Employment', style: style)),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topLeft,
                child: Text('Dear,', style: style)),
            Text(
              'With reference to your application for employment and the subsequent interview you had with us, we are pleased to offer you employment with   (${contractModel.userCityFrom})',
              style: style,
              textAlign: TextAlign.justify,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text('on the following terms and conditions.',
                    style: style)),
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.topLeft,
                child: Text('Our Company is An FYP ka aidea', style: style)),
            Text(
              ' This offer is subject to the fulfillment of the pre-contractual conditions of you being found medically fit and verification done by the Company of the accuracy of testimonials and information provided by you.',
              style: style,
              textAlign: TextAlign.justify,
            ),
            Text(contractModel.contractDetail?.warning == null
                ? ''
                : 'additional info : ${contractModel.contractDetail?.warning}')
          ],
        ),
      ),
    );
  }
}

final style = GoogleFonts.spartan(
    height: 2,
    fontSize: 12,
    color: Colors.black,
    wordSpacing: 2,
    fontWeight: FontWeight.bold);
