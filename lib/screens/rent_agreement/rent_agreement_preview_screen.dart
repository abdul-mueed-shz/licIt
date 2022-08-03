import 'package:flutter/material.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/rent_agreement/rental_provider.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentAgreementPreviewScreen extends StatefulWidget {
  static const String routeName = '/RentAgreementPreviewScreen';
  const RentAgreementPreviewScreen({Key? key}) : super(key: key);

  @override
  State<RentAgreementPreviewScreen> createState() =>
      _RentAgreementPreviewScreenState();
}

class _RentAgreementPreviewScreenState
    extends State<RentAgreementPreviewScreen> {
  String cnic = PrefStorage.instance.id ?? '';

  @override
  Widget build(BuildContext context) {
    final contractModel =
        ModalRoute.of(context)?.settings.arguments as ContractModel;
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
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  String getDate(ContractModel contractModel) {
    String date = contractModel.contractStartDate ?? '';
    print(date);
    final dateTime = DateTime.parse(date);
    final formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }
}
