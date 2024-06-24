import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<int?> getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");

    if (user != null) {
      final userData = jsonDecode(user);
      final dynamic userIdData = userData['id'];

      if (userIdData != null) {
        return int.tryParse(userIdData.toString());
      }
    }

    return null;
  }
}
