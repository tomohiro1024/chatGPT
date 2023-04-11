import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gpt/models/chat_model.dart';
import 'package:http/http.dart' as http;

import '../constants/api_consts.dart';
import '../models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/models'),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print('jsonResponse error: ${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse: $jsonResponse');
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // log('temp: ${value['id']}');
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      log('error: $e');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessageGPT(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse('$BASE_URL/chat/completions'),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print('jsonResponse error: ${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        // log('jsonResponse.text: ${jsonResponse['choices'][0]['text']}');
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['message']['content'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log('error: $e');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse('$BASE_URL/completions'),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"model": modelId, "prompt": message, "max_tokens": 100},
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print('jsonResponse error: ${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        // log('jsonResponse.text: ${jsonResponse['choices'][0]['text']}');
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['text'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log('error: $e');
      rethrow;
    }
  }
}
