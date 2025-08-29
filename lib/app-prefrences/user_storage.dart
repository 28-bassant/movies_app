import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/register_response.dart';

class UserStorage {
  static const String key = "user";

  static Future<void> saveUser(UserData user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(user.toJson()));
  }

  static Future<UserData?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null) return null;

    return UserData.fromJson(jsonDecode(data));
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

