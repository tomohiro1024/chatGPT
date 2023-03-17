import 'package:chat_gpt/widgets/drop_down.dart';
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
        backgroundColor: Colors.pinkAccent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text('選択：')),
                SizedBox(width: 30),
                Flexible(flex: 2, child: ModelsDropDownWidgets()),
              ],
            ),
          );
        });
  }
}
