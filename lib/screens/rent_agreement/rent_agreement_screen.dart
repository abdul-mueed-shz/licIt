import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/rent_agreement/rental_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentAgreementScreen extends StatefulWidget {
  static const String routeName = '/RentAgreementScreen';
  const RentAgreementScreen({Key? key}) : super(key: key);

  @override
  State<RentAgreementScreen> createState() => _RentAgreementScreenState();
}

class _RentAgreementScreenState extends State<RentAgreementScreen> {
  final formDataKey = GlobalKey<FormState>();

  @override
  void initState() {
    final pref = storage.contract;
    final provider = context.read<RentalProvider>();
    if (pref?.rentalAgreementUserNameTO != null &&
        pref?.rentalAgreementUserNameFrom != null) {
      provider.getDataFromPref();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formDataKey,
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(storage.id)
                .collection("contract")
                .doc(storage.contract?.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.data();
                if (data != null) {
                  final contractData = ContractModel.fromJson(data);
                  storage.setContract(contractData);
                }
              }
              return SafeArea(
                  bottom: false,
                  maintainBottomViewPadding: true,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Column(
                            children: [
                              const SizedBox(height: 30),
                              Text("\t\t\t\t\tRental Agreement",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spartan(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      letterSpacing: 2)),
                              const SizedBox(height: 30),
                              const FormatFillInTheBlanks(),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: DeleteBacKFunctionality(
                                        iconData: Icons
                                            .keyboard_double_arrow_left_outlined,
                                        onTap: _homeBack),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: DeleteBacKFunctionality(
                                        iconData: Icons.keyboard_backspace,
                                        onTap: _deleteTap),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 5,
                                    child:
                                        MyElevatedButton('Next', onTap: _tap),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: DeleteBacKFunctionality(
                                        iconData: Icons.delete,
                                        onTap: _deleteTap),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

  void _homeBack(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(TabScreen.routeName));
  }

  void _deleteTap(BuildContext context) {}

  void _tap(BuildContext context) async {
    final provider = context.read<RentalProvider>();
    provider.updateGeneralTextField();
    if (formDataKey.currentState!.validate()) {
      Navigator.pushNamed(context, WarningScreen.routeName);
    }
  }
}

class FormatFillInTheBlanks extends StatefulWidget {
  const FormatFillInTheBlanks({Key? key}) : super(key: key);

  @override
  State<FormatFillInTheBlanks> createState() => _FormatFillInTheBlanksState();
}

class _FormatFillInTheBlanksState extends State<FormatFillInTheBlanks> {
  final style = const TextStyle(
    height: 1.0,
    color: Colors.grey,
    fontSize: 12,
    //fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    final provider = context.read<RentalProvider>();
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            height: 0.4,
            fontWeight: FontWeight.bold),
        children: <InlineSpan>[
          const TextSpan(
            text: 'This agreement is made and executed at',
            style: const TextStyle(
              height: 1.0,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: SecretWord(
                    answer: "lahore",
                    answerLength: 15,
                    controller: provider.rentalAgreementLocation,
                    answerHint: '______')),
          ),
          TextSpan(
            text: 'on',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160),
                child: SecretWord(
                  answer: "lahore",
                  answerLength: 30,
                  controller: provider.rentalAgreementDate,
                  answerHint: '______',
                )),
          ),
          TextSpan(text: 'by and between ', style: style),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 60),
                child: SecretWord(
                  answer: "lahore",
                  answerLength: 15,
                  controller: provider.rentalAgreementUserNameFrom,
                  answerHint: '______',
                )),
          ),
          const TextSpan(
            text: ',',
            style: TextStyle(
                height: 1.0,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 8,
              controller: provider.rentalAgreementGender,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'aged',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 6,
              controller: provider.rentalAgreementAge,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'years ,',
            style: style,
          ),
          TextSpan(
            text: 'residing at',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementResiding,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 14,
              controller: provider.rentalAgreementUserAddressFrom,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCityFrom,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserAreaCodeFrom,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCountryFrom,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'and having ID card No. ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserCnicFrom,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text:
                'hereinafter jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          TextSpan(
            text: '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAnd',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserNameTO,
              answerHint: '______',
            ),
          ),
          const TextSpan(
            text: ',',
            style: TextStyle(
                height: 1.0,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 8,
              controller: provider.rentalAgreementUserGender,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'aged',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 6,
              controller: provider.rentalAgreementUserAgeTo,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'years ,',
            style: style,
          ),
          TextSpan(
            text: 'having permanent address at ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserResidingTo,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserAddressTo,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCityTo,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserAreaCodeTo,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserCountryTo,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'and having ID card No. ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserCnicTo,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text:
                'herein after jointly and severally called the "Landlord”, which expression shall include his heirs, legal representatives, successors and assigns',
            style: style,
          ),
          TextSpan(
            text: '\n\n',
            style: style,
          ),
          TextSpan(
            text: 'whereas the Landlord is the absolute owner of the',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouse,
              answerHint: '______',
            ),
          ),
          TextSpan(text: 'House situated at ', style: style),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseBlock,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseAddress,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHouseCity,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserHouseAreaCode,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: ',',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 10,
              controller: provider.rentalAgreementUserHouseCountry,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'consisting of ',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 16,
              controller: provider.rentalAgreementUserHouseBedroom,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 16,
              controller: provider.rentalAgreementUserHouseBathroom,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 13,
              controller: provider.rentalAgreementUserHouseBalconey,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserHouseCarPorch,
              answerHint: '______',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 15,
              controller: provider.rentalAgreementUserHousekitchen,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text: 'and',
            style: style,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SecretWord(
              answer: "lahore",
              answerLength: 20,
              controller: provider.rentalAgreementUserHouseAnyFitting,
              answerHint: '______',
            ),
          ),
          TextSpan(
            text:
                '& fixtures and inventory of the equipments as detailed in the annexure, hereinafter referred to as "Leased Premises',
            style: style,
          ),
          TextSpan(
            text:
                '\n\nNOW THIS DEED WITNESSETH AS FOLLOWS:\n\n 1. Rent and Deposit \n a. The lease in respect of the "Leased Premises" commenced from 02nd March 2022 and shall terminate on 02/02/2023 ( for a period of 11 months ). Thereafter, the lease may be extended further on mutual consent of both the parties.\n b. The Tenant shall pay the Landlord a monthly rent of Rs15,000/- (Rupees Fifteen Thousand only). The rent shall be paid on or before day 5 of each English Calendar Month. \n c. The Tenant has paid the Landlord an interest free, refundable, security deposit of Rs30,000/- (Rupees Thirty Thousand only). [The deposit amount is paid by Cheque No. e2342344234 dated 28th February 2022, issued by BOPITU.]',
            style: style,
          ),
          TextSpan(
            text:
                '\n\n 2. Maintenance, Electricity and Water Charges \n a. The Tenant shall pay to the Landlord a monthly maintenance charge of Rs500/-(Rupees Five Hundred Only) towards maintenance of “Leased Premises”. \n b. During the lease period, in addition to the monthly rent payable to Landlord, the Tenant shall pay for the use of electricity, gas and water as per bills received from the authorities concerned directly.\n c. It is the responsibility of the Landlord to pay and clear all the dues of electricity bills & water bills according to the readings on the respective meters till the date the possession of the premises is handed over by the Landlord to the Tenant. \n d. And it is the responsibility of the Tenant to pay the same up to the date of vacating the property at the time of handing over possession of the premises back to the Landlord.',
            style: style,
          ),
          TextSpan(
            text:
                '\n\n 3. Damages, Repairs and Alterations\na. All the sanitary, electrical and other fittings and fixtures and appliances in the premises shall be handed over from the Landlord to the Tenant in good working condition. There will be a 3 week maintenance period after the possession of Tenant. If during these 3 weeks any defect in the same is identified & duly notified, the Landlord shall be responsible to repair/ replace the same at his own cost. Upon returning the premises, all the sanitary, electrical and other fittings and fixtures shall be restored by the Tenant to a good condition as they are at present, subject to normal wear and tear or damage by acts of God. \nb. The day-to-day minor repairs such as leakage in the sanitary fittings, water taps and electrical usage etc. will be the responsibility of the Tenant at his own expense. However, any structural or major repairs, if so required, shall be carried out by the Landlord.\nc. The Landlord shall hold the right to visit in person or authorized agents, servants, workmen etc., to enter the Leased Premises for inspection (not exceeding once in a month) or to carry out repairs/construction, as and when required, by giving a 24 hours notice to the Tenant. \nd. No structural additions or alterations shall be made by the Tenant in the premises without the prior written consent from the Landlord. On termination of the tenancy or earlier, the Tenant shall restore the changes made, if any, to the original state. \ne. The Landlord represents that the Leased Premises is free from all construction defects such as leakage, cracks in house walls including that of compound walls, breakage of floor tiles, etc.',
            style: style,
          ),
          TextSpan(
            text:
                "\n\n4. Tenant's Responsibilities \nThe Tenant hereby assures to the covenants with the Landlord that: \na. The Tenant shall not sublet, assign or part with the Leased Premises in whole or part thereof to any person under any circumstance whatsoever and the same shall be used for the bonafide residential purposes of the Tenant and his family and guests. \nb. The Tenant will keep the Landlord free of harm and free from all losses, damage, liability or expense due to acts or neglects of the Tenant or his visitors whether in the leased premises or elsewhere in the building or its approaches. \nc. The Tenant shall maintain the Leased Premises in good and tenable condition. The Tenant shall hand over the vacant and peaceful possession of the Leased Premises on termination of the lease period, in the same condition subject to natural wear and tear. \nd. Late Payment Fine - If the Tenant fails to pay the rent on the fixed date of payment, he shall be liable to pay a fine at the rate of Rs50/(Rupees Fifty only) per day till the date of payment. \n[\n5. Landlord's Responsibilities \nThe Landlord hereby assures to the covenants with the Tenant that: \na. The Tenant, abiding by the terms of the lease, shall be entitled to peacefully and quietly hold and enjoy the Leased Premises during the period of this lease, free of any interference from the Landlord. \nb. The Landlord shall indemnify the Tenant against all damages, costs and expenses incurred by the Tenant as a result of any defect in the title of the Landlord which disturbs the possession and enjoyment of the Leased Premises by the Tenant under the covenants herein before contained.\nc. The Landlord shall acknowledge and give valid receipts for each and every payment made by the Tenant to the Landlord. \nd. The Landlord represents that he has complied with all the statutory payments of the property including that of taxes, penalties, electric charges, water charges etc if any. The Landlord also represents that there is no Charge including mortgage due existing on the Leased Premises which would affect the peaceful possession by the Tenant of the Leased Premises.",
            style: style,
          ),
          TextSpan(
            text:
                '\n\n\n6. Lease Termination & Extension \na. Notice Period - The lease shall terminate at the end of the lease period as referred above or by a prior notice of 1 month by either parties, after the lock-in period, if any.\nb. Percentage increase in Rent - The lease may be extended further on termination by both parties on mutual consent with 5% increase in the monthly rent. \nc. Non-Payment of Rent - If the Tenant fails to pay the monthly rent for a continuous period of two months, or if the Tenant fails to abide by any of the covenants above, the Landlord may terminate the lease. \nd. If the Tenant cannot use the premises or any part thereof for residential purposes because of natural calamities or any commotions, or is acquired by any Government authority, the Tenant shall have the right to terminate the lease forthwith and vacate the premises and the Landlord shall refund the deposits and advance payments to the Tenant. \ne. In the event the Landlord sells, transfers or alienates the leased premises or any part thereof or its right, title and interest, then the Landlord shall terminate the lease after giving two months notice to the Tenant. ',
            style: style,
          ),
          TextSpan(
            text:
                '\n\n7. Additional Clauses\n\na. Refund of Security Deposit - The Security deposit shall be refunded by the Landlord to the Tenant at the time of handing over possession of the Leased Premises by the Tenant upon expiry or sooner termination of this lease after adjusting the dues (if any) or cost towards damages caused by the negligence of the Tenant or the person he is responsible for. This excludes normal wear & tear and damages due to act of god. No interest shall be paid on the deposit amount.\nb. Non-refund by Landlord - In case the Landlord fails to refund the security deposit to the Tenant on early termination or expiry of the lease agreement, the Tenant is entitled to hold possession of the leased premises, without payment of rent and/or any other charges whatsoever, till such time the Landlord refunds the security deposit to the Tenant. This is in addition to the other legal remedies available to the Tenant to recover the amount from the Landlord.\nc. Lock in Period - The lease shall have a lock-in period of 2 months before which termination is not possible by either parties. If either party terminates the lease during the lock-in period, then they shall pay a sum equal to two months rent to the other party. \nd. Painting - The Landlord shall get the "Leased Premises" painted and cleaned at the time of handing over possession to the Tenant. The Tenant shall pay to the Landlord the painting charges or get the premises painted and cleaned on termination of lease and vacating the premises.\ne. Overstay - In case, where the premises are not vacated by the Tenant, on the termination of the lease period, the Tenant will pay damages calculated twice the rent for any period of occupation commencing from the expiry of the lease period. The payment of damages as aforesaid will not preclude the Landlord from initiating legal proceedings against the Tenant for the same. \nf. Pets - The Tenant shall not be allowed to keep any pets within the premises.\ng. The Tenant and the Landlord represent and warrant that they are fully empowered and competent to make this lease. \nh. This agreement shall be executed in duplicate. The original shall be retained by the Landlord and the duplicate by the Tenant.',
            style: style,
          ),
          TextSpan(
            text:
                '\n\nAnnexure \n\nThe list of fixtures, fittings and utilities that shall be provided along with the rental premise is given in the list below. \n\nA.Furniture \n1. Wardrobe \n2. Crockery Shelf \n3. TV shelf \n4. Curtains \n5. Curtain Rods \n6. Sofa \n7.Cot\n8. Dining Table \n\nB. Appliances \n\n1. Geyser \n2. Air Conditioner \n3. Water Purifier \n4. Gas Stove \n5. Refrigerator\n6. Dishwasher\n7. Washing Machine\n8. TV\n\nC. Fittings\n\n1. Ceiling Fans\n2. Bulbs\n3. Tube lights\n4. Fancy Lights\n5. CFL Bulbs\n6. Chimney \n7. Exhaust Fans\n8. Wash Basin ',
            style: style,
          ),
        ],
      ),
    );
  }
}

class SecretWord extends StatelessWidget {
  final String answer;
  final int answerLength;
  final String answerHint;
  final double answerWidth;

  final TextEditingController controller;

  SecretWord({
    Key? key,
    required this.answer,
    required this.controller,
    required this.answerLength,
    this.answerHint = '_',
    this.answerWidth = 10,
  }) : super(key: key);

  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        width: answerWidth * answerLength,
        height: null,

        //  margin: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
            maxLines: null,
            controller: controller,
            cursorColor: Colors.cyanAccent,
            cursorRadius: const Radius.circular(12.0),
            cursorWidth: 2.0,
            style: TextStyle(
              color: (value == answer) ? Colors.grey : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              //  height: 0.5,
            ),
            //textAlign: TextAlign.left,
            autofocus: true,
            onChanged: (text) {
              value = text;
            },
            decoration: InputDecoration(
              //labelText: 'Name *',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
              hintText: answerHint,
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                // height: 0.5,
              ),
            )));
  }
}
