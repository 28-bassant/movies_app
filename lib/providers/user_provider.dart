import 'package:flutter/material.dart';

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
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> loadUser() async {
    _user = await UserStorage.getUser();
    notifyListeners();
  }
}

