import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<Map<String, dynamic>?> getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");

    if (user != null) {
      final userData = jsonDecode(user);

      return userData;
    }

    return null;
  }
}
