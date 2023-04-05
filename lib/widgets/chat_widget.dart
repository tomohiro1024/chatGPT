import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color:
              chatIndex == 0 ? Colors.orange.shade100 : Colors.green.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  chatIndex == 0 ? Icons.person : Icons.smart_toy,
                  color: chatIndex == 0 ? Colors.pink : Colors.green,
                ),
                SizedBox(width: 10),
                Expanded(
                    child: chatIndex == 0
                        ? Text(msg)
                        : AnimatedTextKit(animatedTexts: [
                            TypewriterAnimatedText(
                              msg.trim(),
                            ),
                          ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
