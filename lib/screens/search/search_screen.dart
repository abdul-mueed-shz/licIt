import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/local_user.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/searchScreen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? currentUserCnic = storage.id;
  List<LocalUser> searchlist = [];
  LocalUser? targetUser;

  void _onTapSettingsIcon(
      BuildContext context, TextEditingController controller) {
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
    userdata();
  }

  Future<void> userdata() async {
    final collection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await collection.where('cnicNo', isNotEqualTo: currentUserCnic).get();
    for (final queryDocumentSnapshot in querySnapshot.docs) {
      final userData = queryDocumentSnapshot.data();
      print(userData);
      print(currentUserCnic);
      searchlist.add(LocalUser.fromJson(userData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return searchlist.where((user) => (user.name)
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }
              },
              optionsViewBuilder:
                  (context, Function(String) onSelected, userData) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemBuilder: (context, index) {
                    targetUser = userData.elementAt(index) as LocalUser;
                    final name = targetUser!.name;
                    final imagePath = targetUser!.cnicImageUrl;
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black, // Set border color
                            width: 0.0), // Set border width
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        // Make rounded corner of border
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: imagePath == null
                              ? const Icon(Icons.person,
                                  color: Colors.white, size: 20)
                              : ClipOval(child: Image.network(imagePath)),
                        ),
                        title: Text(name),
                        onTap: () {
                          onSelected(targetUser!.cnicNo);
                        },
                      ),
                    );
                  },
                  itemCount: userData.length,
                );
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                return Padding(
                  padding: EdgeInsets.zero,
                  child: TextFormField(
                    onEditingComplete: onEditingComplete,
                    controller: controller,
                    maxLines: 1,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      suffixIcon: RotatedBox(
                          quarterTurns: 3,
                          child: IconButton(
                              onPressed: () =>
                                  _onTapSettingsIcon(context, controller),
                              icon: const Icon(Icons.clear),
                              color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.lightBlue,
                          )),
                      hintText: 'Enter Name',
                      fillColor: Colors.red,
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      // isDense: true,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
