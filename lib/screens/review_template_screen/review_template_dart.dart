import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/rent_agreement/pdf_review.dart';
import 'package:fyp/screens/rent_agreement/rental_provider.dart';
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
  final String? imageWitness1;
  final String? imageWitness2;
  final String selectedStatus;
  final ReviewModel? reviewModel;
  final String witness1Name;
  final String witness2Name;

  const ReviewTemplateScreen({
    Key? key,
    this.reviewModel,
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
    this.imageWitness1,
    this.imageWitness2,
    required this.witness1Name,
    required this.witness2Name,
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
                if (widget.contractModel.contractStatus == 'Promise') {
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
                } else if (widget.contractModel.contractStatus == 'Rental') {
                  final pdfview = await PdfReview.generateCenteredText(
                      widget.contractModel.rentalAgreementLocation,
                      widget.contractModel.rentalAgreementDate,
                      widget.contractModel.rentalAgreementUserNameFrom,
                      widget.contractModel.rentalAgreementGender,
                      widget.contractModel.rentalAgreementAge,
                      widget.contractModel.rentalAgreementResiding,
                      widget.contractModel.rentalAgreementUserAddressFrom,
                      widget.contractModel.rentalAgreementUserCityFrom,
                      widget.contractModel.rentalAgreementUserAreaCodeFrom,
                      widget.contractModel.rentalAgreementUserCountryFrom,
                      widget.contractModel.rentalAgreementUserCnicFrom,
                      widget.contractModel.rentalAgreementUserNameTO,
                      widget.contractModel.rentalAgreementUserGender,
                      widget.contractModel.rentalAgreementUserAgeTo,
                      widget.contractModel.rentalAgreementUserResidingTo,
                      widget.contractModel.rentalAgreementUserAddressTo,
                      widget.contractModel.rentalAgreementUserCityTo,
                      widget.contractModel.rentalAgreementUserAreaCodeTo,
                      widget.contractModel.rentalAgreementUserCountryTo,
                      widget.contractModel.rentalAgreementUserCnicTo,
                      widget.contractModel.rentalAgreementUserHouse,
                      widget.contractModel.rentalAgreementUserHouseBlock,
                      widget.contractModel.rentalAgreementUserHouseAddress,
                      widget.contractModel.rentalAgreementUserHouseCity,
                      widget.contractModel.rentalAgreementUserHouseAreaCode,
                      widget.contractModel.rentalAgreementUserHouseCountry,
                      widget.contractModel.rentalAgreementUserHouseBedroom,
                      widget.contractModel.rentalAgreementUserHouseBathroom,
                      widget.contractModel.rentalAgreementUserHouseBalconey,
                      widget.contractModel.rentalAgreementUserHouseCarPorch,
                      widget.contractModel.rentalAgreementUserHousekitchen,
                      widget.contractModel.rentalAgreementUserHouseAnyFitting);
                  PdfReview.openFile(pdfview);
                }
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
                      MyPreviewScreen(
                          witness1Name: widget.witness1Name,
                          witness2Name: widget.witness2Name,
                          reviewModel: widget.reviewModel,
                          contractModel: widget.contractModel,
                          requestImage: widget.requestImage,
                          reviewImage: widget.reviewImage,
                          userNameFrom: widget.userNameFrom,
                          userNameTo: widget.userNameTo,
                          witness2status: widget.witnessStatus2,
                          witness1status: widget.witnessStatus1,
                          imageWitness1: widget.imageWitness1,
                          imageWitness2: widget.imageWitness2,
                          witness1: widget.witness1Id ?? '',
                          witness2: widget.witness2Id ?? ''),
                    if (widget.contractModel.contractStatus == 'Handy')
                      MyHandyPreview(
                          witness1Name: widget.witness1Name,
                          witness2Name: widget.witness2Name,
                          contractModel: widget.contractModel,
                          requestImage: widget.requestImage,
                          reviewModel: widget.reviewModel,
                          reviewImage: widget.reviewImage,
                          userNameFrom: widget.userNameFrom,
                          userNameTo: widget.userNameTo,
                          witness2status: widget.witnessStatus2,
                          witness1status: widget.witnessStatus1,
                          imageWitness1: widget.imageWitness1,
                          imageWitness2: widget.imageWitness2,
                          witness1: widget.witness1Id ?? '',
                          witness2: widget.witness2Id ?? ''),
                    if (widget.contractModel.contractStatus == 'Rental')
                      MyRentalView(
                          witness1Name: widget.witness1Name,
                          witness2Name: widget.witness2Name,
                          contractModel: widget.contractModel,
                          requestImage: widget.requestImage,
                          reviewModel: widget.reviewModel,
                          witness2status: widget.witnessStatus2,
                          witness1status: widget.witnessStatus1,
                          witness1: widget.witness1Id ?? '',
                          imageWitness1: widget.imageWitness1,
                          imageWitness2: widget.imageWitness2,
                          witness2: widget.witness2Id ?? '',
                          reviewImage: widget.reviewImage,
                          userNameFrom: widget.userNameFrom,
                          userNameTo: widget.userNameTo),
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
  final String reviewImage;
  final String userNameFrom;
  final String witness1Name;
  final String witness2Name;
  final String witness1;
  final String witness2;
  final bool witness1status;
  final String? imageWitness1;
  final String? imageWitness2;
  final bool witness2status;
  final String requestImage;
  final String userNameTo;

  final ReviewModel? reviewModel;
  const MyPreviewScreen(
      {Key? key,
      required this.contractModel,
      required this.reviewImage,
      this.reviewModel,
      required this.userNameFrom,
      required this.requestImage,
      required this.userNameTo,
      required this.witness1,
      required this.witness2,
      required this.witness1status,
      required this.witness2status,
      this.imageWitness1,
      this.imageWitness2,
      required this.witness1Name,
      required this.witness2Name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Non-Disclosure\nConfidently Agreement',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This Agreement is entered into on Date: ${getDate()}\t\tBetween M/s \t\t${contractModel.userNameFrom} ,addressed at  ${contractModel.userAddressFrom}, ${contractModel.userLocalityFrom} ,${contractModel.userCityFrom}, ${contractModel.userProvinceFrom} ${contractModel.userCountryFrom} , hereinafter referred to as the Disclosing party',
                style: GoogleFonts.spartan(
                    height: 2,
                    fontSize: 12,
                    color: Colors.black,
                    wordSpacing: 2,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '\nAND\n',
                  style: GoogleFonts.spartan(
                      height: 2,
                      fontSize: 12,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'M/s . \t\t${contractModel.userNameTo},\t\taddressed at \t\t${contractModel.userAddressTo} ,\t\t${contractModel.userLocalityTo},\t\t${contractModel.userCityTo},\t\t${contractModel.userProvinceTo},\t\t${contractModel.userCountryTo}',
                style: GoogleFonts.spartan(
                    height: 2,
                    fontSize: 12,
                    color: Colors.black,
                    wordSpacing: 2,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                'here in after referred to as the Receiving party collectively referred to as the "Parties".',
                style: GoogleFonts.spartan(
                    height: 2,
                    fontSize: 12,
                    color: Colors.black,
                    wordSpacing: 2,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Text(
                  '\nAdditional Info : ${contractModel.contractDetail?.warning ?? ''}\n',
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center),
              Text(
                "Here in after referred to as the Receiving Party  collectively referred to as the \"Parties\".\n\n"
                '\n\n1. Purpose of Agreement\n\n'
                'To prohibit unauthorized disclosure of proprietary and confidential information which are disclosed by the Disclosing party to the Receiving party either prior to this agreement or after that. All such information is referred to as "proprietary information" or "confidential information".\n\n'
                ' \n2. Confidential or Proprietary information\n '
                ' \n\n1.	These shall be included as confidential information - any data or information that is proprietary to the Disclosing Party and not generally known to the public whether by written or oral means and includes any marketing, financial, operational, sales or any other business plans or product or service or customer information of the past, present or future of the disclosing party or any scientific or technical information, invention, design, process, procedure, formula, technology or method or any concepts, reports, data, development tools, computer software and programs, trade secrets and any other information recognized as confidential information of the Disclosing Party.\n\n'
                '\n\n2.	The following shall not be considered as confidential information:\n\n'
                '\n\na.	Information that was known by the Receiving Party prior to receiving the Confidential Information from the Disclosing Party or'
                '\n\nb.	Known to the Receiving Party from a third-party source and the Receiving Party not knowing to be under an obligation to Disclosing Party to maintain confidentiality or'
                '\n\nc.	Becomes publicly available through no fault of the Receiving Party or'
                '\n\nd.	Is required to be disclosed in a judicial or administrative proceeding, or is required to be disclosed by law or regulation.\n\n'
                '\n\n 3.	Terms and conditions\n\n'
                ' \n\na.	Non-Disclosure: The Receiving Party acknowledges and understands that the Confidential Information is proprietary to the Disclosing Party. The Receiving party shall hold the Proprietary Information in strict confidence and take all precautions to protect such Proprietary Information and not disclose any such confidential Proprietary Information to any third person.\n\n'
                '\n\n b.	Non-Use: The Receiving party shall not at any time, make any use or copy or modify or publish such Proprietary Information except to be used solely in connection with business relationship between the parties and not for any purpose other than as authorized by this agreement without the prior written consent of the Disclosing Party. The Receiving party shall not have any other right or title on the Confidential information. Title to the Confidential Information will remain solely in the Disclosing Party and any modifications and improvements made by the Receiving Party shall be the sole property of the Disclosing Party.\n\n'
                '\n\nc.	Sub-Contract: The Receiving Party shall sign and procure a nondisclosure or similar agreement in content substantially similar to this Agreement with its employees, agents and subcontractors to whom Proprietary Information is disclosed or who have access to it.\n\n'
                '\n\nd.	Termination and Return of proprietary materials: Receiving Party shall immediately return to the Disclosing Party all Proprietary Information and all documents or content containing any such Proprietary Information and all copies or extracts of the same Information upon (1) The completion of the dealings between the parties. (2) The termination of this Agreement; or (3) On written request by the Disclosing Party at any time. And also to erase or destroy such information that has been copied or transcribed into another document and cannot be returned.\n\n'
                ' \n\ne.	Not to Assign, Transfer or Amend: This Agreement shall not be assigned, transferred or amended, partly or wholly without the consent of the other Party.\n\n'
                ' \n\nf.	Effective Period: The rights and obligations of each Party with respect to all Confidential Information of the other Party that is received under this Agreement, shall remain in effect for a period of from the date of disclosure of Confidential Information.\n\n'
                '\n\ng.	Governing Law: In case of any disputes arising out of or in relation to this agreement, the parties submit to the jurisdiction of courts in Pakistan situated in OR Arbitration: In case of disputes, this agreement shall be subject to the decisions of an Arbitrator mutually agreed upon by the parties to this agreement in.\n\n'
                '\n\nh.	Enforceability: If any of the provisions of this agreement is termed illegal or unenforceable, in whole or part, only such terms will be deemed to be excluded and the rest of the provisions and clauses shall be unaffected and remain valid and enforceable.\n\n'
                '\n\ni.	Breach and Relief: Any unauthorized use or disclosure of Confidential Information by Receiving Party or its Representatives amounts to breach and the Receiving Party shall notify the Disclosing Party immediately upon discovery of such breach and shall cooperate to help the Disclosing Party regain possession of Confidential Information and prevent its further unauthorized use. The Disclosing Party shall be entitled to injunctive relief preventing the dissemination of any Confidential Information in violation of the terms of this Agreement and such injunctive relief shall be in addition to any other remedies available under law or in equity. Disclosing Party shall be entitled to recover its costs.\n\n'
                '\n\nThis Agreement constitutes the entire understanding between the parties and supersedes all prior agreements or understandings.\n\n',
                style: GoogleFonts.spartan(
                    fontSize: 12, fontWeight: FontWeight.w700),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (reviewModel?.user2Signed == true)
                    Column(children: [
                      Image.network(reviewImage,
                          fit: BoxFit.contain, width: 100, height: 100),
                      Text(reviewModel?.reviewName ?? userNameFrom),
                    ]),
                  if (reviewModel?.user1Signed == true)
                    Column(
                      children: [
                        Image.network(requestImage,
                            fit: BoxFit.contain, width: 100, height: 100),
                        Text(reviewModel?.requestName ?? userNameTo),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  witness1.isNotEmpty && witness1status == true
                      ? Column(
                          children: [
                            Image.network(imageWitness1 ?? '',
                                width: 100, height: 100, fit: BoxFit.contain),
                            Text(witness1Name)
                          ],
                        )
                      : const SizedBox(),
                  witness2.isNotEmpty && witness2status == true
                      ? Column(
                          children: [
                            Image.network(imageWitness2 ?? '',
                                width: 100, height: 100, fit: BoxFit.contain),
                            Text(witness2Name)
                          ],
                        )
                      : const SizedBox()
                ],
              )
            ],
          ),
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
  final String reviewImage;
  final String userNameFrom;
  final String requestImage;
  final String userNameTo;
  final String witness1;
  final String witness2;
  final String? imageWitness1;
  final String? imageWitness2;
  final bool witness1status;
  final bool witness2status;
  final ReviewModel? reviewModel;
  final String witness1Name;
  final String witness2Name;

  const MyHandyPreview(
      {Key? key,
      required this.contractModel,
      required this.reviewImage,
      required this.userNameFrom,
      required this.requestImage,
      required this.userNameTo,
      required this.witness1,
      required this.witness2,
      required this.witness1status,
      required this.witness2status,
      this.reviewModel,
      this.imageWitness1,
      this.imageWitness2,
      required this.witness1Name,
      required this.witness2Name})
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
            Text(
              contractModel.contractDetail?.warning == null
                  ? ''
                  : 'additional info : ${contractModel.contractDetail?.warning}',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Image.network(reviewImage,
                      fit: BoxFit.contain, width: 100, height: 100),
                  Text(userNameFrom),
                ]),
                Column(children: [
                  Image.network(requestImage,
                      fit: BoxFit.contain, width: 100, height: 100),
                  Text(userNameTo),
                ]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                witness1.isNotEmpty && witness1status == true
                    ? Column(
                        children: [
                          Image.network(imageWitness1 ?? '',
                              width: 100, height: 100, fit: BoxFit.contain),
                          Text(witness1Name)
                        ],
                      )
                    : const SizedBox(),
                witness2.isNotEmpty && witness2status == true
                    ? Column(
                        children: [
                          Image.network(imageWitness2 ?? '',
                              width: 100, height: 100, fit: BoxFit.contain),
                          Text(witness2Name)
                        ],
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyRentalView extends StatelessWidget {
  final ContractModel contractModel;
  final String reviewImage;
  final String userNameFrom;
  final String requestImage;
  final String userNameTo;
  final String witness1;
  final String witness2;
  final bool witness1status;
  final String? imageWitness1;
  final String? imageWitness2;
  final bool witness2status;
  final ReviewModel? reviewModel;
  final String witness1Name;
  final String witness2Name;

  const MyRentalView(
      {Key? key,
      required this.contractModel,
      required this.reviewImage,
      required this.userNameFrom,
      required this.requestImage,
      required this.userNameTo,
      required this.witness1,
      required this.witness2,
      required this.witness1status,
      required this.witness2status,
      this.reviewModel,
      this.imageWitness1,
      this.imageWitness2,
      required this.witness1Name,
      required this.witness2Name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Contract'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.navigate_before),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                icon: const Icon(Icons.navigate_next_outlined)),
          ],
        ),
        body: SafeArea(
          child: Consumer<RentalProvider>(
            builder: (context, provider, child) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Rental Agreement',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spartan(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          letterSpacing: 2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'THIS AGREEMENT is made and executed at  (${contractModel.rentalAgreementLocation}) on ( ${contractModel.rentalAgreementDate}) by and between (${contractModel.rentalAgreementUserNameFrom}), (${contractModel.rentalAgreementGender}), aged (${contractModel.rentalAgreementAge}) years,residing at  ( ${contractModel.rentalAgreementResiding} ), (${contractModel.rentalAgreementUserAddressFrom}),(${contractModel.rentalAgreementUserAddressFrom}),(${contractModel.rentalAgreementUserCountryFrom}) and having ID card No. ${contractModel.rentalAgreementUserCnicFrom}. (hereinafter jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns).',
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
                      ' (${contractModel.rentalAgreementUserNameTO}), (${contractModel.rentalAgreementUserGender}), aged (${contractModel.rentalAgreementUserAgeTo}) , having permanent address at, ( ${contractModel.rentalAgreementUserResidingTo} ), (${contractModel.rentalAgreementUserAddressTo}),(${contractModel.rentalAgreementUserCityTo})(${contractModel.rentalAgreementUserAreaCodeTo}), (${contractModel.rentalAgreementUserCountryTo}) and having ID card No. ${contractModel.rentalAgreementUserCnicTo}. (hereinafter called the “Tenant", which expression shall include his legal representatives, successors and assigns).',
                      style: GoogleFonts.spartan(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          wordSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      'WHEREAS the Landlord is the absolute owner of the (${contractModel.rentalAgreementUserHouse}) House situated at (${contractModel.rentalAgreementUserHouseBlock}), (${contractModel.rentalAgreementUserHouseAddress}), (${contractModel.rentalAgreementUserHouseCity})(${contractModel.rentalAgreementUserHouseAreaCode}), (${contractModel.rentalAgreementUserHouseCountry}), consisting of (${contractModel.rentalAgreementUserHouseBedroom}), (${contractModel.rentalAgreementUserHouseBathroom}), (${contractModel.rentalAgreementUserHouseBalconey}),(${contractModel.rentalAgreementUserHouseCarPorch}), (${contractModel.rentalAgreementUserHousekitchen}) and (${contractModel.rentalAgreementUserHouseAnyFitting}) & fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises".',
                      style: GoogleFonts.spartan(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          wordSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      contractModel.contractDetail?.warning == null
                          ? ''
                          : 'Additional Info :${contractModel.contractDetail?.warning ?? ''}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Image.network(reviewImage,
                              fit: BoxFit.contain, width: 100, height: 100),
                          Text(userNameFrom),
                        ]),
                        Column(children: [
                          Image.network(requestImage,
                              fit: BoxFit.contain, width: 100, height: 100),
                          Text(userNameTo),
                        ]),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        witness1.isNotEmpty && witness1status == true
                            ? Column(
                                children: [
                                  Image.network(imageWitness1 ?? '',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain),
                                  Text(witness1Name)
                                ],
                              )
                            : const SizedBox(),
                        witness2.isNotEmpty && witness2status == true
                            ? Column(
                                children: [
                                  Image.network(imageWitness2 ?? '',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain),
                                  Text(witness2Name)
                                ],
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}

final style = GoogleFonts.spartan(
    height: 2,
    fontSize: 12,
    color: Colors.black,
    wordSpacing: 2,
    fontWeight: FontWeight.bold);
