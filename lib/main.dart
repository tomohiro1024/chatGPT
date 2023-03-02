import 'package:chat_gpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orange.shade100,
        primarySwatch: Colors.orange,
        appBarTheme: AppBarTheme(
          color: Colors.orange,
        ),
      ),
      home: const ChatScreen(),
    );
  }
}
