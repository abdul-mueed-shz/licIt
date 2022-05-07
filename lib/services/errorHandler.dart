import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static Future errorDialogue(BuildContext context, e) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
