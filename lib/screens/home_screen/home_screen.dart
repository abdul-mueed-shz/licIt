// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/login_page/login_screen.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/component/penalties_screen.dart';
import 'package:fyp/screens/promise_agreement/component/time_line.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/screens/promise_agreement/promise_provider.dart';
import 'package:fyp/util/pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final List<String> tabs = [
  'All',
  'Active',
  'Drafts',
  'Pending',
  'Rejected',
  'Deleted'
];

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cnic = Prefs.instance.getLoginUserId();
  Color greenColor = const Color(0xFF00AF19);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Rental App',
            style: GoogleFonts.lato(),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 35.0,
                  color: greenColor,
                ),
                onPressed: () {
                  Prefs.instance.allClear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            labelStyle: TextStyle(fontSize: 14.0),
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                      height: 30,
                      iconMargin: EdgeInsets.all(20),
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: [
            AllTabView(onPressed: () {}),
            Center(child: Text('Active')),
            TabDraftView(),
            Center(child: Text('Pending')),
            Center(child: Text('Rejected')),
            Center(child: Text('Deleted')),
          ],
        ),
      ),
    );
  }
}

class AllTabView extends StatelessWidget {
  final VoidCallback? onPressed;
  const AllTabView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(Prefs.instance.getLoginUserId() ?? '3123456789123')
            .collection('contract')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return Text("Something error");
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot element) {
                Map<String, dynamic> mydata =
                    element.data()! as Map<String, dynamic>;
                print(mydata);
                final e = ContractModel.fromJson(mydata);
                return GeneralHomeCard(
                    contractModelData: e, onPressed: onPressed);
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class GeneralHomeCard extends StatelessWidget {
  final ContractModel contractModelData;
  final VoidCallback? onPressed;
  const GeneralHomeCard(
      {Key? key, required this.contractModelData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
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
              SizedBox(height: 5),
              Text(contractModelData.contractDetail?.executionDate.toString() ??
                  ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: CircleAvatar(child: Icon(Icons.abc_outlined))),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        contractModelData.status,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
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
            .doc(Prefs.instance.getLoginUserId() ?? '3123456789123')
            .collection('contract')
            .where('status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return Text("Something error");
            }
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Contract"));
            }
            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot element) {
                Map<String, dynamic> mydata =
                    element.data()! as Map<String, dynamic>;
                print(mydata);
                final e = ContractModel.fromJson(mydata);
                return GeneralHomeCard(
                  contractModelData: e,
                  onPressed: () async {
                    Prefs.instance.removeUser();
                    context.read<PromiseProvider>().setContractPref(e);
                    Prefs.instance.setContract(e);
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
                    }
                  },
                );
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

// class CustomCardAllUi extends StatelessWidget {
//   const CustomCardAllUi({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<PromiseProvider>().contracts;
//     return GridView.count(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         mainAxisSpacing: 5,
//         crossAxisSpacing: 5,
//         childAspectRatio: 2 / 3,
//         crossAxisCount: 2,
//         children: provider
//             .map((e) => GeneralHomeCard(contractModelData: e))
//             .toList());
//   }
// }
