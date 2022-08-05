import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/tab/tab_screen.dart';
import 'package:fyp/widget/button.dart';
import 'package:fyp/widget/hide_keyboard_on_background_tap.dart';
import 'package:fyp/widget/validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' as math;

class SearchScreen extends StatefulWidget {
  final bool witness;
  final String? id;
  static const String routeName = '/searchScreen';
  const SearchScreen({Key? key, this.witness = false, this.id})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key,
        child: HideKeyboardOnBackgroundTap(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                      color: Colors.green,
                    ),
                    child: const Text(
                      'LicIt.',
                      style: TextStyle(
                        color: Colors.white, fontSize: 60,
                        fontWeight: FontWeight.bold,

                        //fontFamily:,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: controller,
                      maxLines: 1,
                      validator: Validator.validateCnic,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.blue),
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
                        hintText: 'Enter Cnic Number',
                        fillColor: Colors.red,
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        // isDense: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: myButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myButton() {
    return MyElevatedButton(
        widget.witness ? 'Send For Review For Witness' : 'Send For Review',
        onTap: widget.witness ? sendForWitness : sendForReview,
        margin: const EdgeInsets.symmetric(vertical: 40));
  }

  void sendForReview(BuildContext context) async {
    EasyLoading.show();
    if (key.currentState!.validate()) {
      final userEntered = controller.text.trim();
      final user = await userRepository.checkExist(userEntered);

      if (userEntered == storage.id) {
        EasyLoading.dismiss();
        return EasyLoading.showError("This User Currently Login");
      }
      if (user == 'User Exist') {
        final data = await userRepository.get(controller.text.trim());
        EasyLoading.dismiss();
        final confirmation =
            await confirmDialog(context, controller.text.trim()) ?? false;
        if (confirmation == false) {
          return EasyLoading.showInfo('Try Again');
        }
        EasyLoading.show();
        final user1Data =
            await userRepository.get(storage.id ?? '3123456789123');
        final reviewIDModel = ReviewIDModel(
            contractID: storage.contract!.id,
            userName: data?.name ?? '',
            contractName: storage.contract?.contractName ?? '');
        final contractReviewModel = ContractDetailTab(
          requestName: data?.name ?? '',
          reviewName: user1Data?.name ?? '',
          contractID: storage.contract?.id ?? '3123456789123',
          contractName: storage.contract?.contractName ?? "Contract",
          contractUserId: storage.id ?? '3123456789123',
        );
        await updateFirebaseField(data?.cnicNo ?? '3123456789123',
            [reviewIDModel.toJson()], contractReviewModel);
        await updateFirebaseField(storage.id ?? '3123456789123',
            [reviewIDModel.toJson()], contractReviewModel);
        final reviewModel = ReviewModel(
            reviewRequestId: storage.id ?? '3123456789123',
            contractID: storage.contract!.id,
            receiverRequestId: data?.cnicNo ?? '3123456789123',
            contractName: storage.contract?.contractName ?? "Contract",
            reviewName: data?.name ?? '',
            requestName: user1Data?.name ?? '');
        await reviewRepository.add(reviewModel);
        await contractRepository.update(
            storage.contract!.id, {'contractDetail.showSendOption': true});
        await context.read<PromiseProvider>().send(
            data!.token!,
            '${user1Data?.name ?? ''} created a contract for you',
            'Licit Agreement');
        await EasyLoading.dismiss();
        rotateDialog(context, data);
        controller.clear();
      }
      if (user == 'no user Found') {
        EasyLoading.dismiss();
        return EasyLoading.showError('No user Found');
      }
    }

    EasyLoading.dismiss();
  }

  _onTapSettingsIcon(BuildContext context, TextEditingController controller) {
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendForWitness(BuildContext context) async {
    if (key.currentState!.validate()) {
      EasyLoading.show();
      final userCnic = controller.text.trim();
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCnic)
          .get();
      final userExist = user.data() ?? {};
      if (userExist == {}) {
        return EasyLoading.showError("No User Found");
      }
      final reviewModel = await FirebaseFirestore.instance
          .collection('reviews')
          .doc(widget.id)
          .get();
      final reviewModels = reviewModel.data() ?? {};
      if (reviewModels.isEmpty) {
        return EasyLoading.showInfo("SomeThing Happens");
      }
      final review = ReviewModel.fromJson(reviewModels);

      if (userCnic == review.reviewRequestId) {
        return EasyLoading.showError("User Can't be Send to Contract person");
      }
      if (userCnic == review.receiverRequestId) {
        return EasyLoading.showError("User Can't be send to own");
      }
      final myUser = await userRepository.get(userCnic);
      final contractModelData = await FirebaseFirestore.instance
          .collection('users')
          .doc(review.reviewRequestId)
          .collection('contract')
          .doc(widget.id)
          .get();
      final contractModelShowData = contractModelData.data() ?? {};

      if (contractModelShowData.isEmpty) return;
      final contractModel = ContractModel.fromJson(contractModelShowData);
      final reviewUser = await userRepository.get(review.reviewRequestId);
      final requestUser = await userRepository.get(review.receiverRequestId);
      final requestUserList = reviewUser?.witnessScreenShow ?? [];
      final reviewUserList = requestUser?.witnessScreenShow ?? [];

      if (contractModel.contractDetail?.witness1?.witnessId == null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(review.reviewRequestId)
            .collection('contract')
            .doc(review.contractID)
            .update({
          'contractDetail.witness1.witnessId': userCnic,
          'contractDetail.witness1.senderId': review.reviewRequestId,
        });
        final showModel = requestUserList
            .where((element) => element.contractID == review.contractID)
            .toList()
            .first;
        await userRepository.update(userCnic, {
          'signedWitness': [showModel.toJson()],
        });
        await userRepository.update(storage.id ?? '3123456789123', {
          'witnessScreenShow': FieldValue.arrayRemove([showModel.toJson()])
        });
        await context.read<PromiseProvider>().send(
            myUser!.token!,
            '${review.requestName} create Witness  contract for you',
            'Licit Agreement');
        EasyLoading.dismiss();
        rotateDialog(context, myUser);
      } else if (contractModel.contractDetail?.witness1?.witnessId ==
          userCnic) {
        return EasyLoading.showError('This user already selected for witness');
      } else if (contractModel.contractDetail?.witness2?.witnessId == null) {
        EasyLoading.show();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(review.reviewRequestId)
            .collection('contract')
            .doc(review.contractID)
            .update({
          'contractDetail.witness2.witnessId': userCnic,
          'contractDetail.witness2.senderId': review.receiverRequestId,
        });
        final showModel = reviewUserList
            .where((element) => element.contractID == review.contractID)
            .toList()
            .first;
        await userRepository.update(userCnic, {
          'signedWitness': [showModel.toJson()],
        });
        await userRepository.update(storage.id ?? '3123456789123', {
          'witnessScreenShow': FieldValue.arrayRemove([showModel.toJson()])
        });
        await context.read<PromiseProvider>().send(
            myUser!.token!,
            '${review.requestName} create Witness  contract for you',
            'Licit Agreement');
        EasyLoading.dismiss();
        rotateDialog(context, myUser);
      }
    }
  }
}

Widget _dialog(BuildContext context, LocalUser? user) {
  return AlertDialog(
    title: const Text("Review"),
    content: Text(
        "${user?.cnicNo},Contract has been sent to ${user?.name} for review"),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(TabScreen.routeName));
          },
          child: const Text("Okay"))
    ],
  );
}

void rotateDialog(BuildContext context, LocalUser? user) {
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      return Transform.rotate(
        angle: math.radians(a1.value * 360),
        child: _dialog(ctx, user),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}

Future<void> updateFirebaseField(
  String cnic,
  List<Map<String, dynamic>> model,
  ContractDetailTab contractDetailTab,
) async {
  return await userRepository.update(cnic, {
    'contractId': FieldValue.arrayUnion(model),
    'contractDetailTab': FieldValue.arrayUnion([contractDetailTab.toJson()])
  });
}

Future<bool?> confirmDialog(BuildContext context, String confirmCnic) async {
  final cnicController = TextEditingController();

  return showGeneralDialog<bool>(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      return Transform.rotate(
        angle: math.radians(a1.value * 360),
        child: AlertDialog(
          title: const Text("Confirmation Dialog"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter Cnic Number Again For Verification",
                style: GoogleFonts.lato(
                  fontSize: 13,
                ),
              ),
              TextFormField(
                controller: cnicController,
                decoration: InputDecoration(hintText: confirmCnic),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  if (cnicController.text.trim() == confirmCnic) {
                    Navigator.pop(context, true);
                  } else {
                    Navigator.pop(context, false);
                  }
                },
                child: const Text("Verify")),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"))
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
