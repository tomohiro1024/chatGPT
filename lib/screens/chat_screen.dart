import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../providers/chats_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      // drawer: Drawer(
      //   backgroundColor: Colors.orangeAccent.shade100,
      //   child: ListView(
      //     children: [
      //       Container(
      //         child: ListTile(
      //           title: Row(
      //             children: [
      //               Icon(
      //                 Icons.add,
      //                 color: Colors.green,
      //               ),
      //               SizedBox(width: 15),
      //               Text(
      //                 'メニュー',
      //                 style: TextStyle(
      //                     fontSize: 20,
      //                     color: Colors.blue,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 5),
      //       Container(
      //         decoration: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(color: Colors.orange),
      //             bottom: BorderSide(color: Colors.orange),
      //           ),
      //         ),
      //         child: ListTile(
      //           title: Row(
      //             children: [
      //               IconButton(
      //                 onPressed: () async {
      //                   Navigator.pop(context);
      //                   Services.showModalSheet(context);
      //                 },
      //                 splashRadius: 15,
      //                 splashColor: Colors.green,
      //                 icon: Icon(
      //                   Icons.list,
      //                   color: Colors.pinkAccent,
      //                 ),
      //               ),
      //               TextButton(
      //                 child: Text(
      //                   'チャットモデル',
      //                   style:
      //                       TextStyle(fontSize: 20, color: Colors.pinkAccent),
      //                 ),
      //                 onPressed: () async {
      //                   Navigator.pop(context);
      //                   Services.showModalSheet(context);
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Container(
      //         decoration: BoxDecoration(
      //           border: Border(
      //             bottom: BorderSide(color: Colors.orange),
      //           ),
      //         ),
      //         child: ListTile(
      //           title: Row(
      //             children: [
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 splashRadius: 15,
      //                 splashColor: Colors.pinkAccent,
      //                 icon: Icon(
      //                   Icons.exit_to_app,
      //                   color: Colors.red,
      //                 ),
      //               ),
      //               TextButton(
      //                 child: Text(
      //                   '閉じる',
      //                   style: TextStyle(fontSize: 20, color: Colors.red),
      //                 ),
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: NewGradientAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.meteor,
              color: Colors.redAccent,
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '無料チャット',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextSpan(
                    text: 'AI',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        gradient: LinearGradient(
          colors: [
            Colors.cyan.shade300,
            Colors.yellow.shade300,
            Colors.pink.shade300,
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider.getChatList[index].msg,
                      chatIndex: chatProvider.getChatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitChasingDots(
                color: Colors.orangeAccent,
                size: 20,
              ),
            ],
            const SizedBox(height: 10),
            Material(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(chatProvider: chatProvider);
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: '何か質問してみよう！',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessageFCT(chatProvider: chatProvider);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT({required ChatProvider chatProvider}) async {
    if (_isTyping) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent.shade200,
                title: const Text(
                  '警告',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        '一度に複数のメッセージを送信することはできません',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      '閉じる',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent.shade200,
                title: const Text(
                  '警告',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const [
                      Text(
                        '何か入力をしてください！',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      '閉じる',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(msg: msg);
      // chatList.addAll(await ApiService.sendMessage(
      //     message: textEditingController.text, modelId: "text-davinci-003"));
      setState(() {});
    } catch (e) {
      print('error: $e');

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent.shade200,
                title: const Text(
                  '警告',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const [
                      Text(
                        '通信エラーです。改善するまで少々お待ちください',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      '閉じる',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
