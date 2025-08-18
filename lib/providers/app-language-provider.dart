import 'package:flutter/material.dart';

import '../app-prefrences/app-prefrences.dart';


class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  LanguageProvider() {
    _loadSavedLanguage();
  }

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    await AppPrefrences.saveLanguage(newLanguage);
    notifyListeners();
  }

  void _loadSavedLanguage() async {
    final savedLang = await AppPrefrences.getSavedLanguage();
    if (savedLang != null) {
      appLanguage = savedLang;
      notifyListeners();
    }
  }
}
