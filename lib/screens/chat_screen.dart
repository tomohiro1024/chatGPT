import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../providers/chats_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  bool _isTyping = false;
  bool _isVisible = true;

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

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final InAppReview inAppReview = InAppReview.instance;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.cyanAccent.shade100,
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('images/icon.png'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'メニュー',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border(
            //       top: BorderSide(color: Colors.orange),
            //       bottom: BorderSide(color: Colors.orange),
            //     ),
            //   ),
            //   child: ListTile(
            //     title: Row(
            //       children: [
            //         IconButton(
            //           onPressed: () async {
            //             Navigator.pop(context);
            //             Services.showModalSheet(context);
            //           },
            //           splashRadius: 15,
            //           splashColor: Colors.green,
            //           icon: Icon(
            //             Icons.list,
            //             color: Colors.pinkAccent,
            //           ),
            //         ),
            //         TextButton(
            //           child: Text(
            //             'チャットモデル',
            //             style:
            //                 TextStyle(fontSize: 20, color: Colors.pinkAccent),
            //           ),
            //           onPressed: () async {
            //             Navigator.pop(context);
            //             Services.showModalSheet(context);
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              decoration: const BoxDecoration(
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
                        if (await inAppReview.isAvailable()) {
                          inAppReview.openStoreListing(
                              appStoreId: 'id6447792822');
                        }
                        //// launchUrlを使用してストアページ表示させたい場合 ////
                        // var uri = Uri.parse(
                        //     'https://apps.apple.com/jp/app/id6447792822/reviews');
                        // await launchUrl(
                        //   uri,
                        //   mode: LaunchMode.externalApplication,
                        // );
                      },
                      splashRadius: 15,
                      splashColor: Colors.pinkAccent,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'レビューする',
                        style:
                            TextStyle(fontSize: 20, color: Colors.pinkAccent),
                      ),
                      onPressed: () async {
                        if (await inAppReview.isAvailable()) {
                          inAppReview.openStoreListing(
                              appStoreId: 'id6447792822');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.orange),
                ),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        String text =
                            '超大人気アプリ！「チャットAIさん」\nhttps://apps.apple.com/jp/app/id6447792822';
                        Share.share(text);
                        Navigator.pop(context);
                      },
                      splashRadius: 15,
                      splashColor: Colors.pinkAccent,
                      icon: const Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        '共有する',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      onPressed: () {
                        String text =
                            '超大人気アプリ！「チャットAIさん」\nhttps://apps.apple.com/jp/app/id6447792822';
                        Share.share(text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
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
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        '閉じる',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'バージョン: 1.2.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
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
                    text: 'チャット',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextSpan(
                    text: 'AI',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'さん',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
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
            _isVisible
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.robot,
                          color: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text('AIがあなたのチャットを待っています...'),
                        SpinKitPulse(
                          color: Colors.green,
                          size: 30,
                        ),
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(height: 15),
            if (_isTyping) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitChasingDots(
                    color: Colors.orangeAccent,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text('考え中です...'),
                ],
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
                        setState(() {
                          _isVisible = false;
                        });
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
                    children: const [
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

    List<String> prohibitedWordsList = ['ゴミ', '死', '殺', 'うん', 'ガキ', 'チビ', 'ちん'];

    if (prohibitedWordsList
        .any((word) => textEditingController.text.contains(word))) {
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
                        '不適切な文字列が含まれています',
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
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(msg: msg);
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
