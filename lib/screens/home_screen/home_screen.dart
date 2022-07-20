import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/contract_detail_tab/contract_detail_tab.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/component/penalties_screen.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/screens/review_template_screen/review_template_dart.dart';
import 'package:fyp/screens/warning_screen/warning_screen.dart';
import 'package:fyp/util/constant.dart';
import 'package:fyp/util/my_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final List<String> tabs = [
  'All',
  'Active',
  'Drafts',
  'Signed Tab',
  'Witness',
  'Deleted',
  'Detail Tab'
];

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cnic = storage.id;
  Color greenColor = const Color(0xFF00AF19);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Rental App',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 35.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await storage.allClear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            labelStyle: const TextStyle(fontSize: 14.0),
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                      height: 30,
                      iconMargin: const EdgeInsets.all(20),
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: [
            AllTabView(onPressed: (_) {}),
            const ReviewView(),
            const TabDraftView(),
            const SignedView(),
            const WitnessView(),
            const DeletedTab(),
            const ContractDetailTabScreen(),
          ],
        ),
      ),
    );
  }
}

class AllTabView extends StatelessWidget {
  final BuildContextCallback? onPressed;
  const AllTabView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id ?? '3123456789123')
            .collection('contract')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot element) {
                Map<String, dynamic> mydata =
                    element.data()! as Map<String, dynamic>;
                final e = ContractModel.fromJson(mydata);
                return GeneralHomeCard(
                    contractModelData: e, onPressed: (context) => () {});
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class GeneralHomeCard extends StatelessWidget {
  final ContractModel contractModelData;
  final BuildContextCallback onPressed;
  const GeneralHomeCard(
      {Key? key, required this.contractModelData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = contractModelData.contractDetail?.executionDate ?? '';
    return GestureDetector(
      onTap: () => onPressed(context),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contractModelData.contractName,
                style:
                    GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              currentDate.isEmpty
                  ? ''.toText()
                  : currentDate.formattedDate.toText(),
              const SizedBox(width: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        contractModelData.status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabDraftView extends StatelessWidget {
  const TabDraftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id ?? '3123456789123')
            .collection('contract')
            .where('status', isEqualTo: 'Draft')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot element) {
                Map<String, dynamic> mydata =
                    element.data()! as Map<String, dynamic>;
                final e = ContractModel.fromJson(mydata);

                return GeneralHomeCard(
                  contractModelData: e,
                  onPressed: (context) => _draftPressed(context, e),
                );
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  void _draftPressed(BuildContext context, ContractModel e) async {
    await storage.setContract(e);
    if (e.savedPlace == PromiseAgreement.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
    } else if (e.savedPlace == TimeLineScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
    } else if (e.savedPlace == AdditionalScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
    } else if (e.savedPlace == PenaltiesScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
    } else if (e.savedPlace == GeneralTemplate.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
      Navigator.pushNamed(context, GeneralTemplate.routeName);
    } else if (e.savedPlace == WarningScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
      Navigator.pushNamed(context, GeneralTemplate.routeName);
      Navigator.pushNamed(context, WarningScreen.routeName);
    }
  }
}

class ReviewView extends StatefulWidget {
  const ReviewView({Key? key}) : super(key: key);

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id ?? '3123456789123')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data?.data() == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No Review Contract"));
          }
          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data?.data() ?? {};
            final user = LocalUser.fromJson(data);
            if (user.contractId.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 3,
                crossAxisCount: 2,
                children: user.contractId.map(
                  (e) {
                    return GestureDetector(
                      onTap: () async {
                        final reviewsCollectionData = await FirebaseFirestore
                            .instance
                            .collection('reviews')
                            .doc(e.contractID)
                            .get();
                        final myData = reviewsCollectionData.data() ?? {};
                        if (myData == {}) return;
                        final reviewModel = ReviewModel.fromJson(myData);
                        context
                            .read<PromiseProvider>()
                            .updateShow(reviewModel.user2Signed);

                        final myId = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(reviewModel.reviewRequestId)
                            .collection('contract')
                            .doc(e.contractID)
                            .get();

                        final myReviewModel = myId.data() ?? {};
                        if (myData == {}) return;
                        final contractData =
                            ContractModel.fromJson(myReviewModel);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewTemplateScreen(
                                      reviewRequestID:
                                          reviewModel.reviewRequestId,
                                      warning: contractData
                                              .contractDetail?.warning ??
                                          '',
                                      receiverRequestId:
                                          reviewModel.receiverRequestId,
                                      startDate:
                                          contractData.contractStartDate ?? '',
                                      endDate:
                                          contractData.contractEndDate ?? '',
                                      userNameFrom:
                                          contractData.userNameFrom ?? '',
                                      userNameTo: contractData.userNameTo ?? '',
                                      userAddressFrom:
                                          contractData.userAddressFrom ?? '',
                                      userAddressTo:
                                          contractData.userAddressTo ?? '',
                                      userCityFrom:
                                          contractData.userCityFrom ?? '',
                                      userCityTo: contractData.userCityTo ?? '',
                                      userCountryFrom:
                                          contractData.userCountryFrom ?? '',
                                      userCountryTo:
                                          contractData.userCountryTo ?? '',
                                      userLocalityFrom:
                                          contractData.userLocalityFrom ?? '',
                                      userLocalityTo:
                                          contractData.userLocalityTo ?? '',
                                      userProvinceFrom:
                                          contractData.userProvinceFrom ?? '',
                                      userProvinceTo:
                                          contractData.userProvinceTo ?? '',
                                      contractName: e.contractName,
                                      contractID: e.contractID,
                                    )));
                      },
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('reviews')
                            .doc(e.contractID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final model = snapshot.data?.data() ?? {};

                            if (model == {}) {
                              return const Text("No data");
                            }
                            final myReviewModel = ReviewModel.fromJson(model);
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(e.contractName),
                                      Text(
                                        myReviewModel.reviewName.toUpperCase(),
                                        style: GoogleFonts.lato(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      if (myReviewModel.user2Signed == true)
                                        Column(
                                          children: [
                                            StatusSigned(
                                                title: myReviewModel.user2Signed
                                                    ? 'Signed'
                                                    : 'Unsigned',
                                                color: myReviewModel.user2Signed
                                                    ? Colors.orange
                                                    : Colors.red),
                                            const SizedBox(height: 5),
                                            Text(myReviewModel.requestName
                                                .toUpperCase()),
                                            const SizedBox(height: 5),
                                            StatusSigned(
                                              color: myReviewModel.user1Signed
                                                  ? Colors.orange
                                                  : Colors.red,
                                              title: myReviewModel.user1Signed
                                                  ? 'Signed'
                                                  : 'unsigned',
                                            ),
                                            const SizedBox(height: 5),
                                            if (myReviewModel.user1Signed ==
                                                    false &&
                                                myReviewModel.reviewRequestId ==
                                                    storage.id)
                                              GestureDetector(
                                                  onTap: () async {
                                                    final removeReviewId =
                                                        ReviewIDModel(
                                                            contractID:
                                                                e.contractID,
                                                            userName:
                                                                e.userName,
                                                            contractName:
                                                                e.contractName);
                                                    EasyLoading.show();
                                                    final update = {
                                                      'user1Signed': true,
                                                    };
                                                    await reviewRepository
                                                        .update(e.contractID,
                                                            update);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .reviewRequestId)
                                                        .collection('contract')
                                                        .doc(e.contractID)
                                                        .update({
                                                      'status': 'All',
                                                    });
                                                    final model = WitnessShowModel(
                                                        contractName:
                                                            myReviewModel
                                                                .contractName,
                                                        contractID:
                                                            e.contractID,
                                                        user1: myReviewModel
                                                            .reviewName,
                                                        user2: myReviewModel
                                                            .requestName,
                                                        witnessTabShow: true,
                                                        contractIdUser:
                                                            myReviewModel
                                                                .reviewRequestId);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .receiverRequestId)
                                                        .update({
                                                      'witnessScreenShow':
                                                          FieldValue.arrayUnion(
                                                              [model.toJson()])
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .receiverRequestId)
                                                        .update({
                                                      'rejectWitness': [
                                                        model.toJson()
                                                      ]
                                                    });
                                                    final model1 =
                                                        WitnessShowModel(
                                                      contractName:
                                                          myReviewModel
                                                              .contractName,
                                                      contractID: e.contractID,
                                                      user1: myReviewModel
                                                          .reviewName,
                                                      user2: myReviewModel
                                                          .requestName,
                                                      witnessTabShow: true,
                                                      contractIdUser:
                                                          myReviewModel
                                                              .reviewRequestId,
                                                    );
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .reviewRequestId)
                                                        .update(
                                                      {
                                                        'witnessScreenShow':
                                                            FieldValue
                                                                .arrayUnion([
                                                          model1.toJson()
                                                        ])
                                                      },
                                                    );
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .reviewRequestId)
                                                        .update({
                                                      'rejectWitness': [
                                                        model1.toJson()
                                                      ]
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .reviewRequestId)
                                                        .update({
                                                      'contractId': FieldValue
                                                          .arrayRemove([
                                                        removeReviewId.toJson()
                                                      ])
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(myReviewModel
                                                            .receiverRequestId)
                                                        .update({
                                                      'contractId': FieldValue
                                                          .arrayRemove([
                                                        removeReviewId.toJson()
                                                      ])
                                                    });
                                                    EasyLoading.dismiss();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape
                                                                .rectangle),
                                                    child: Text(
                                                        "Click to Signed",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white)),
                                                  )),
                                          ],
                                        ),
                                      const SizedBox(height: 20),
                                      const Text("Contract Review"),
                                      const CustomCardStatus(),
                                    ],
                                  )),
                            );
                          }

                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    );
                  },
                ).toList());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class CustomCardStatus extends StatelessWidget {
  final Widget child;
  final String title;
  final Color color;
  const CustomCardStatus({
    Key? key,
    this.color = Colors.orange,
    this.title = 'Pending',
    this.child = const CircleAvatar(child: Icon(Icons.abc_outlined)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: child),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12)),
          ),
        )
      ],
    );
  }
}

class DeletedTab extends StatelessWidget {
  const DeletedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id ?? '3123456789123')
            .collection('contract')
            .where('status', isEqualTo: 'Delete')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot element) {
                Map<String, dynamic> mydata =
                    element.data()! as Map<String, dynamic>;
                final e = ContractModel.fromJson(mydata);

                return GeneralHomeCard(
                  contractModelData: e,
                  onPressed: (context) => _pressed(context, e),
                );
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  void _pressed(BuildContext context, ContractModel details) {
    showDialog(
        context: context,
        builder: (BuildContext context) => showDialogBox1(context, details));
  }

  void updateStatus(ContractModel details) async {
    String status;
    status = details.status != 'Delete' ? 'Delete' : 'Draft';
    final updatedContract = {'status': status};
    await contractRepository.update(details.id, updatedContract);
  }

  Widget showDialogBox1(BuildContext context, ContractModel details) {
    String status = details.status;
    return AlertDialog(
      title: const Text('Are you Sure ?'),
      content: const Text('Do you want to Delete this  Agreement?'),
      actions: <Widget>[
        TextButton(
            child: status != 'Delete'
                ? const Text('Delete')
                : const Text('Restore'),
            onPressed: () {
              updateStatus(details);
              Navigator.of(context).pop();
            }),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _deletePressed(BuildContext context, ContractModel e) async {
    await storage.setContract(e);
    if (e.savedPlace == PromiseAgreement.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
    } else if (e.savedPlace == TimeLineScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
    } else if (e.savedPlace == AdditionalScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
    } else if (e.savedPlace == PenaltiesScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
    } else if (e.savedPlace == GeneralTemplate.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
      Navigator.pushNamed(context, GeneralTemplate.routeName);
    } else if (e.savedPlace == WarningScreen.routeName) {
      Navigator.pushNamed(context, PromiseAgreement.routeName);
      Navigator.pushNamed(context, TimeLineScreen.routeName);
      Navigator.pushNamed(context, AdditionalScreen.routeName);
      Navigator.pushNamed(context, PenaltiesScreen.routeName);
      Navigator.pushNamed(context, GeneralTemplate.routeName);
      Navigator.pushNamed(context, WarningScreen.routeName);
    }
  }
}

class StatusSigned extends StatelessWidget {
  final String title;
  final Color color;
  const StatusSigned(
      {Key? key, this.title = 'UnSigned', this.color = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: 12, color: Colors.white),
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
    );
  }
}

class WitnessView extends StatelessWidget {
  const WitnessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(storage.id)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(child: Text("No data Found"));
          }
          if (snapshot.hasError) {
            return const Text("Something error");
          }
          if (snapshot.data?.data() == null) {
            return const Center(child: Text("No Witness"));
          }
        }
        if (snapshot.hasData) {
          final myUser = snapshot.data?.data();
          final localUser = LocalUser.fromJson(myUser!);
          if (localUser.witnessScreenShow.isEmpty) {
            return const Center(child: Text("No Contract"));
          }
          return GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            children: localUser.witnessScreenShow.map((element) {
              return ShowWitness(
                myContractId: element.contractID,
                userId: element.contractIdUser,
                user1ContractName: element.user1,
                user2ContractName: element.user2,
                witnessStatus: element.witnessTabShow,
                contractName: element.contractName,
              );
            }).toList(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SignedView extends StatelessWidget {
  const SignedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
            if (snapshot.data?.data() == null) {
              return const Center(child: Text("No Witness"));
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            final myUser = snapshot.data?.data();
            final localUser = LocalUser.fromJson(myUser!);
            if (localUser.signedWitness.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: localUser.signedWitness.map((e) {
                return ShowWitness(
                    myContractId: e.contractID,
                    userId: e.contractIdUser,
                    user1ContractName: e.user1,
                    user2ContractName: e.user2,
                    contractName: e.contractName,
                    status: 'signed');
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class ShowWitness extends StatelessWidget {
  final String myContractId;
  final String userId;
  final String user1ContractName;
  final String user2ContractName;
  final bool witnessStatus;
  final String contractName;
  final String status;

  const ShowWitness(
      {Key? key,
      required this.myContractId,
      required this.userId,
      this.status = 'witness',
      this.witnessStatus = false,
      required this.user1ContractName,
      required this.user2ContractName,
      required this.contractName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final contract = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('contract')
            .doc(myContractId)
            .get();
        final reviewModelFirebase = await FirebaseFirestore.instance
            .collection("reviews")
            .doc(myContractId)
            .get();
        final contractModel = contract.data() ?? {};
        if (contractModel.isEmpty) return;
        final contractData = ContractModel.fromJson(contractModel);

        final myReview = reviewModelFirebase.data() ?? {};
        if (myReview.isEmpty) return;

        final review = ReviewModel.fromJson(myReview);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReviewTemplateScreen(
                      reviewRequestID: review.reviewRequestId,
                      witnessShow: witnessStatus,
                      selectedStatus: status,
                      witnessStatus2: contractData
                              .contractDetail?.witness2?.witnessSigned ??
                          false,
                      witnessStatus1: contractData
                              .contractDetail?.witness1?.witnessSigned ??
                          false,
                      warning: contractData.contractDetail?.warning ?? '',
                      receiverRequestId: review.receiverRequestId,
                      startDate: contractData.contractStartDate ?? '',
                      endDate: contractData.contractEndDate ?? '',
                      userNameFrom: contractData.userNameFrom ?? '',
                      userNameTo: contractData.userNameTo ?? '',
                      userAddressFrom: contractData.userAddressFrom ?? '',
                      userAddressTo: contractData.userAddressTo ?? '',
                      userCityFrom: contractData.userCityFrom ?? '',
                      userCityTo: contractData.userCityTo ?? '',
                      userCountryFrom: contractData.userCountryFrom ?? '',
                      userCountryTo: contractData.userCountryTo ?? '',
                      userLocalityFrom: contractData.userLocalityFrom ?? '',
                      userLocalityTo: contractData.userLocalityTo ?? '',
                      userProvinceFrom: contractData.userProvinceFrom ?? '',
                      userProvinceTo: contractData.userProvinceTo ?? '',
                      contractName: review.contractName,
                      contractID: myContractId,
                      witness1Id:
                          contractData.contractDetail?.witness1?.witnessId,
                      witness2Id:
                          contractData.contractDetail?.witness2?.witnessId,
                    )));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(contractName,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 19)),
            Text("Contract",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 19)),
            const SizedBox(height: 20),
            Text(user1ContractName.toUpperCase(),
                style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Between", style: GoogleFonts.lato()),
            Text(user2ContractName.toUpperCase(),
                style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomCardStatus(title: 'Witness'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractDetailTabScreen extends StatelessWidget {
  const ContractDetailTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(storage.id)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something error");
          }

          if (snapshot.hasData) {
            Map<String, dynamic> mydata = snapshot.data?.data() ?? {};
            if (mydata.isEmpty) return const Text("No Contract");
            final localuser = LocalUser.fromJson(mydata);
            if (localuser.contractDetailTab.isEmpty) {
              return const Center(child: Text("No Contract"));
            }
            return GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 3,
                crossAxisCount: 2,
                children: localuser.contractDetailTab
                    .map((contractInfo) => GestureDetector(
                          onTap: () async {
                            final contract = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(contractInfo.contractUserId)
                                .collection('contract')
                                .doc(contractInfo.contractID)
                                .get();
                            final contractDetail = contract.data() ?? {};
                            final contractModel =
                                ContractModel.fromJson(contractDetail);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ContractDetailScreen(
                                          witness1: contractModel.contractDetail
                                                  ?.witness1?.witnessId ??
                                              '',
                                          witness2: contractModel.contractDetail
                                                  ?.witness2?.witnessId ??
                                              '',
                                          userCityTo:
                                              contractModel.userCityTo ?? '',
                                          warning: contractModel
                                                  .contractDetail?.warning ??
                                              '',
                                          userCityFrom:
                                              contractModel.userCityFrom ?? '',
                                          userAddressFrom:
                                              contractModel.userAddressFrom ??
                                                  '',
                                          userProvinceTo:
                                              contractModel.userProvinceTo ??
                                                  '',
                                          userCountryTo:
                                              contractModel.userCountryTo ?? '',
                                          userNameFrom:
                                              contractModel.userNameFrom ?? '',
                                          userNameTo:
                                              contractModel.userNameTo ?? '',
                                          userAddressTo: '',
                                          userCountryFrom:
                                              contractModel.userCountryFrom ??
                                                  '',
                                          userProvinceFrom:
                                              contractModel.userProvinceFrom ??
                                                  '',
                                          endDate:
                                              contractModel.contractEndDate ??
                                                  '',
                                          userLocalityTo:
                                              contractModel.userLocalityTo ??
                                                  '',
                                          userLocalityFrom:
                                              contractModel.userLocalityFrom ??
                                                  '',
                                          startDate:
                                              contractModel.contractStartDate ??
                                                  '',
                                          witness2status: contractModel
                                                  .contractDetail
                                                  ?.witness1
                                                  ?.witnessSigned ??
                                              false,
                                          witness1status: contractModel
                                                  .contractDetail
                                                  ?.witness2
                                                  ?.witnessSigned ??
                                              false,
                                        )));
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(contractInfo.contractName,
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 19)),
                                Text("Contract",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 19)),
                                const SizedBox(height: 20),
                                Text(contractInfo.requestName.toUpperCase(),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text("Between", style: GoogleFonts.lato()),
                                Text(contractInfo.reviewName.toUpperCase(),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomCardStatus(title: 'Detail'),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
