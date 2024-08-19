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

  static Future<String?> getUserRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString("refreshToken");

    if (refreshToken != null) {
      String refreshTokenData = refreshToken;

      return refreshTokenData;
    }

    return null;
  }

  static Future<void> saveUserBearerToken(String? bearerToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", "$bearerToken");
  }

  static Future<void> saveUserRefreshToken(String? refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("refreshToken", "$refreshToken");
  }
}
