import 'package:flutter/material.dart';

class Services {
  static Future<void> showModalSheet(BuildContext context) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Flexible(child: Text('選択してください：')),
              ],
            ),
          );
        });
  }
}
