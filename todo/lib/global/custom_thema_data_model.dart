import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/custom_thema_data.dart';
import 'global_data_model.dart';

class CustomThemaData extends ChangeNotifier {
  SharedPreferences? preferences;
  bool _isDark = false;
  ThemeData myTheme = lightThemeData;
  CustomThemaData() {
    getLocalData();
  }
  void getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    _isDark = preferences?.getBool("thema") ?? false;
    _isDark ? darkThemaData() : lightThemaData();
  }

  void darkThemaData() {
    myTheme = darkThemeData;
    _isDark = true;
    preferences!.setBool("thema", _isDark);
    logger.wtf("Dark");
    notifyListeners();
  }

  void lightThemaData() {
    myTheme = lightThemeData;
    _isDark = false;
    preferences!.setBool("thema", _isDark);
    logger.wtf("Light");
    notifyListeners();
  }

  set setIsDark(bool isDark) {
    _isDark = isDark;
    isDark ? darkThemaData() : lightThemaData();
  }

  bool get getIsDark => _isDark;
}
