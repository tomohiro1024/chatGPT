import 'package:flutter/cupertino.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> modelsList = [];

  String currentModel = 'text-davinci-001';

  String get getCurrentModel {
    return currentModel;
  }

  List<ModelsModel> get getModelsList {
    return modelsList;
  }
}
