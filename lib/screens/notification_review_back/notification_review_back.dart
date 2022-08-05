import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/promise_provider.dart';
import 'package:fyp/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

class NotificationScreenBack extends StatefulWidget {
  static const String routeName = '/NotificationScreenBack';
  const NotificationScreenBack({Key? key}) : super(key: key);

  @override
  State<NotificationScreenBack> createState() => _NotificationScreenBackState();
}

class _NotificationScreenBackState extends State<NotificationScreenBack> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          ElevatedButton(
            onPressed: () async {
              final model =
                  await reviewRepository.get(storage.contract?.id ?? '');
              await contractRepository
                  .update(storage.contract?.id ?? '', {'isReviewState': false});
              final reviewUser =
                  await userRepository.get(model?.receiverRequestId ?? '');
              await context.read<PromiseProvider>().send(
                  reviewUser?.token ?? '',
                  '${model?.reviewName ?? ''} created a contract for you.',
                  'Licit Agreement');
              rotateDialog(context, reviewUser);
              await EasyLoading.dismiss();
            },
            child: const Text('Click to Notify'),
          ),
        ],
      ),
    );
  }
}
