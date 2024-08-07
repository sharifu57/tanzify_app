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

  static Future<String?> getUserbearerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bearerToken = prefs.getString("token");

    if (bearerToken != null) {
      String bearerTokenData = bearerToken;

      return bearerTokenData;
    }

    return null;
  }
}
