// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/homePage.dart';
import 'package:fyp/services/settingDefaultDatabaseStuff.dart';
import 'package:fyp/templatePage.dart';

class TemplateDrawer extends StatefulWidget {
  const TemplateDrawer({Key? key}) : super(key: key);

  @override
  State<TemplateDrawer> createState() => _TemplateDrawerState();
}

class _TemplateDrawerState extends State<TemplateDrawer> {
  //Database Stuff
  final databaseReference = FirebaseDatabase.instance.ref();

  //Styling Stuff
  Color greenColor = const Color(0xFF00AF19);

  //Content To display Conditions
  // ignore: non_constant_identifier_names
  bool IsContractSublistSelected = false;
  String? currentSelectedTemplate;

  //
  double? _width;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        width: _width, //* 0.88,
        child: Drawer(
          child: Material(
            //color: Colors.blueGrey[500],
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  color: Colors.green[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Choose Template',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: greenColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: greenColor,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                widgetSelector(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  widgetSelector() {
    // return !IsContractSublistSelected
    //     ? contractsListView()
    //     : currentSelectedTemplate != null
    //         ? contractsSubListView(contractName: currentSelectedTemplate!)
    //         : Container(
    //             child: Center(
    //               child: RaisedButton(onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => HomePage(),
    //                   ),
    //                 );
    //               }),
    //             ),
    //           );
    return !IsContractSublistSelected
        ? contractsListView()
        : currentSelectedTemplate != null
            ? selectedTemplateWithDescription()
            : Container(
                child: Center(
                  child: RaisedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }),
                ),
              );
  }

  //List View For Templates
  String theTemplate = 'No Template';
  selectedTemplateWithDescription() {
    SettingDefaultStuff()
        .getTemplate(templateName: currentSelectedTemplate as String)
        .then(
      (value) {
        theTemplate = value;
      },
    );
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: greenColor, //Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
            height: 60,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    '$currentSelectedTemplate',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: greenColor, //Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: SettingDefaultStuff().getDescriptionData(
                    templateName: currentSelectedTemplate.toString(),
                  ),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasError)
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    if (snapshot.hasData)
                      return Text(
                        '${snapshot.data}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                backgroundColor: greenColor,
                onPressed: () {
                  setState(() {
                    IsContractSublistSelected = false;
                    currentSelectedTemplate = null;
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greenColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  IsContractSublistSelected = false;

                  String currenttemplateName =
                      currentSelectedTemplate.toString();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TemplatePage(
                        templateName: currenttemplateName,
                        template: theTemplate,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Begin',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<String> contractList = [];
  contractsListView() {
    return Expanded(
      child: FutureBuilder(
        future: SettingDefaultStuff().getContractLists(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasError)
            return Text(
              '${snapshot.error}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          if (snapshot.hasData) {
            contractList = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              itemCount: contractList.length,
              itemBuilder: (context, index) {
                return buildContractItems(templateName: contractList[index]);
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  buildContractItems({required String templateName}) {
    return Container(
      decoration: BoxDecoration(
        color: greenColor, //Colors.grey[350],
        borderRadius: BorderRadius.circular(20),
      ),
      height: 60,
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: ListTile(
        title: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              5,
            ),
            child: Text(
              templateName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        onTap: () {
          setState(
            () {
              IsContractSublistSelected = true;
              currentSelectedTemplate = templateName;
            },
          );
        },
      ),
    );
  }
  // List<String> contractSubList = [];
  // contractsSubListView({required String contractName}) {
  //   return Expanded(
  //     child: FutureBuilder(
  //       future: SettingDefaultStuff()
  //           .getsublistForContract(contractName: contractName),
  //       builder: (context, AsyncSnapshot<List<String>> snapshot) {
  //         if (snapshot.hasError)
  //           return Text(
  //             '${snapshot.error}',
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           );
  //         if (snapshot.hasData) {
  //           contractSubList = snapshot.data!;
  //           print(contractSubList);
  //           return ListView.builder(
  //             padding: EdgeInsets.only(
  //               left: 30,
  //               right: 30,
  //             ),
  //             itemCount: contractList.length,
  //             itemBuilder: (context, index) {
  //               return buildSubContractItems(templateName: contractList[index]);
  //             },
  //           );
  //         }
  //         return const CircularProgressIndicator();
  //       },
  //     ),
  //   );
  // }

  // buildSubContractItems({required String templateName}) {
  //   print(contractSubList);
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: greenColor, //Colors.grey[350],
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     height: 60,
  //     margin: EdgeInsets.only(
  //       top: 10,
  //       bottom: 10,
  //     ),
  //     padding: EdgeInsets.only(
  //       left: 30,
  //       right: 30,
  //     ),
  //     child: ListTile(
  //       title: SingleChildScrollView(
  //         child: Padding(
  //           padding: EdgeInsets.all(
  //             5,
  //           ),
  //           child: Text(
  //             templateName,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //         ),
  //       ),
  //       onTap: () {
  //         setState(
  //           () {},
  //         );
  //       },
  //     ),
  //   );
  // }

}
