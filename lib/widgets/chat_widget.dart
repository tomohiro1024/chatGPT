import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.orange.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.pink,
                ),
                SizedBox(width: 10),
                Text('Hello'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
