import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(storage.id)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
            if (snapshot.data?.data() == null) {
              return const Center(child: Text("No data Found"));
            }
            if (snapshot.hasError) {
              return const Text("Something error");
            }
            if (snapshot.hasData) {
              final user = snapshot.data?.data();
              if (user == null) {
                return const Center(
                  child: Text("No Notification Found"),
                );
              }
              final localUser = LocalUser.fromJson(user);
              if (localUser.comments.isEmpty) {
                return const Center(child: Text("No Notification"));
              }
              return ListView.builder(
                itemCount: localUser.comments.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Comment by",
                                    style: GoogleFonts.lato(
                                        letterSpacing: 3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      localUser.comments[index].commentName
                                          .toUpperCase(),
                                      style: GoogleFonts.lato()),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Description",
                                    style: GoogleFonts.lato(
                                        letterSpacing: 3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      localUser.comments[index].comment
                                          .toUpperCase(),
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.lato()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
