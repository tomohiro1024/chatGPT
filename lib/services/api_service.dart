import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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

  static Future<List<ModelsModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse('$BASE_URL/completions'),
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
}
