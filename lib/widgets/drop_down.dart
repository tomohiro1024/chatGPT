import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/services/api_service.dart';
import 'package:flutter/material.dart';

class ModelsDropDownWidgets extends StatefulWidget {
  const ModelsDropDownWidgets({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidgets> createState() => _ModelsDropDownWidgetsState();
}

class _ModelsDropDownWidgetsState extends State<ModelsDropDownWidgets> {
  String currentModels = 'text-davinci-001';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
        future: ApiService.getModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: Colors.pinkAccent,
                    iconEnabledColor: Colors.orange,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: Text(snapshot.data![index].id),
                      ),
                    ),
                    value: currentModels,
                    onChanged: (value) {
                      setState(() {
                        currentModels = value.toString();
                      });
                    },
                  ),
                );
        });
  }
}
