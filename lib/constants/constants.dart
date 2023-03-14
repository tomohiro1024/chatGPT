import 'package:flutter/material.dart';

List<String> models = [
  'Model1',
  'Model2',
  'Model3',
  'Model4',
  'Model5',
  'Model6',
];

List<DropdownMenuItem<String>>? get getModelsItem {
  List<DropdownMenuItem<String>>? modelsItems =
      List<DropdownMenuItem<String>>.generate(
    models.length,
    (index) => DropdownMenuItem(
      value: models[index],
      child: Text(models[index]),
    ),
  );
  return modelsItems;
}

final chatMessages = [
  {
    "msg": "こんにちは",
    "chatIndex": 0,
  },
  {
    "msg": "こんにちは！お元気ですか？何かお手伝いできますか？",
    "chatIndex": 1,
  },
  {
    "msg": "Flutterの将来性は？",
    "chatIndex": 0,
  },
  {
    "msg": "Flutterの将来性については、非常に明るいと考えられています。",
    "chatIndex": 1,
  },
  {
    "msg": "ありがとう！",
    "chatIndex": 0,
  },
  {
    "msg": "どういたしまして！他に何か質問があれば、遠慮なくお聞きください。",
    "chatIndex": 1,
  },
];
