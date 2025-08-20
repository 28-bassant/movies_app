import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", userData["id"].toString());
    await prefs.setString("name", userData["name"]);
    await prefs.setString("email", userData["email"]);
    await prefs.setString("phone", userData["phone"]);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "userId": prefs.getString("userId"),
      "name": prefs.getString("name"),
      "email": prefs.getString("email"),
      "phone": prefs.getString("phone"),
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
