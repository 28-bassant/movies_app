import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrences {
  static const String _langKey = 'language';
  static const String _themeKey = 'theme';


  static Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, lang);
  }

  static Future<String?> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey);
  }


  static Future<void> saveTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme == ThemeMode.dark ? 'dark' : 'light');
  }

  static Future<ThemeMode?> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'dark') return ThemeMode.dark;
    if (themeString == 'light') return ThemeMode.light;
    return null;
  }
}