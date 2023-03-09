import 'package:chat_gpt/services/services.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.orangeAccent.shade100,
        child: ListView(
          children: [
            Container(
              child: ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'メニュー',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.orange),
                  bottom: BorderSide(color: Colors.orange),
                ),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        Services.showModalSheet(context);
                      },
                      splashRadius: 15,
                      splashColor: Colors.green,
                      icon: Icon(
                        Icons.list,
                        color: Colors.green,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'チャットモデル',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Services.showModalSheet(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.orange),
                ),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashRadius: 15,
                      splashColor: Colors.pinkAccent,
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        '閉じる',
                        style:
                            TextStyle(fontSize: 20, color: Colors.pinkAccent),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 2,
        title: const Text("無料チャットAI"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatMessages[index]["msg"].toString(),
                      chatIndex: int.parse(
                          chatMessages[index]["chatIndex"].toString()),
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.orangeAccent,
                size: 20,
              ),
              SizedBox(height: 10),
              Material(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          onSubmitted: (value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: '何か質問してみよう！',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
