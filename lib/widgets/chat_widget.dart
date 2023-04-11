import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? Colors.yellow.shade100 : Colors.cyan.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FaIcon(
                  chatIndex == 0
                      ? FontAwesomeIcons.user
                      : FontAwesomeIcons.robot,
                  color: chatIndex == 0 ? Colors.pink : Colors.green,
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: chatIndex == 0
                        ? Text(msg)
                        : AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
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
