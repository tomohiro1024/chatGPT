import 'package:chat_gpt/constants/constants.dart';
import 'package:flutter/material.dart';

class ModelsDropDownWidgets extends StatefulWidget {
  const ModelsDropDownWidgets({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidgets> createState() => _ModelsDropDownWidgetsState();
}

class _ModelsDropDownWidgetsState extends State<ModelsDropDownWidgets> {
  String currentModels = 'Model1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.pinkAccent,
      iconEnabledColor: Colors.orange,
      items: getModelsItem,
      value: currentModels,
      onChanged: (value) {
        setState(() {
          currentModels = value.toString();
        });
      },
    );
  }
}
