import 'package:eventstracker/base/BaseViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeViewModel extends BaseViewModel {
  final TextEditingController textFieldController = TextEditingController();
  SharedPreferences _sharedPreferences;

  WelcomeViewModel({@required SharedPreferences sharedPreferences}) {
    _sharedPreferences = sharedPreferences;
  }

  Future<bool> onSubmit() async {
    if(textFieldController.text.trim().isEmpty) return false;

    final String name = textFieldController.text;

    await _sharedPreferences.setString("name", name);

    return true;
  }
}