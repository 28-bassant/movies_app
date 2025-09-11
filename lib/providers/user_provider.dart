import 'package:flutter/material.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/app-prefrences/token-storage.dart';

import '../app-prefrences/user_storage.dart';
import '../model/register_response.dart';

class UserProvider with ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  bool get isLoggedIn => _user != null;

  void setUserIfExists(UserData? user) {
    if (user != null) {
      _user = user;
    }
  }

  void setUser(UserData user) {
    _user = user;
    UserStorage.saveUser(user);
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    TokenStorage.clearToken();
    UserStorage.clearUser();
  }

  Future<void> loadUser() async {
    _user = await UserStorage.getUser();
    notifyListeners();
  }

  Future<void> updateUser(UserData user) async {
    try {
      await ApiManager.updateProfile(user.name, user.phone, user.avaterId);
      setUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await ApiManager.resetPassword(
        oldPassword: currentPassword,
        newPassword: newPassword,
      );
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
