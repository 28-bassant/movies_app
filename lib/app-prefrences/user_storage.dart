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

// class UserStorage {
//   static const String key = "user";
//
//   static Future<void> saveUser(UserData user) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(user.toJson());
//     print('SAVING USER: $jsonString'); // ← ADD THIS
//     await prefs.setString(key, jsonString);
//     print('USER SAVED SUCCESSFULLY'); // ← ADD THIS
//   }
//
//   static Future<UserData?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(key);
//     print('LOADED FROM STORAGE: $data'); // ← ADD THIS
//     if (data == null) return null;
//
//     try {
//       final user = UserData.fromJson(jsonDecode(data));
//       print('USER LOADED: ${user.name}'); // ← ADD THIS
//       return user;
//     } catch (e) {
//       print('ERROR LOADING USER: $e'); // ← ADD THIS
//       return null;
//     }
//   }
//
//   static Future<void> clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(key);
//     print('USER CLEARED FROM STORAGE');
//   }
// }