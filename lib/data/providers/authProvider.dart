import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/services/dataConnection.dart';
import 'package:tanzify_app/utils/logs.dart';

class AuthProvider with ChangeNotifier {
  Dio dio = Dio();
  String _errorMessage = "";
  String _successMessage = "";
  bool _isLoading = false;
  bool _smallLoading = false;
  late DataConnection _dataConnection;

  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  bool get isLoading => _isLoading;
  bool get smallLoading => _smallLoading;

  Map<String, dynamic>? _userData;
  String? _accessToken;
  String? _refreshToken;
  String? _bearerToken;
  String? _expiresAt;

  Map<String, dynamic>? get userData => _userData;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get bearerToken => _bearerToken;
  String? get expiresAt => _expiresAt;

  AuthProvider() {
    _dataConnection = DataConnection();
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void startSmallLoading() {
    _smallLoading = true;
    notifyListeners();
  }

  void stopSmallLoading() {
    _smallLoading = false;
    notifyListeners();
  }

  Future<bool> forgotPassword(String email) async {
    startLoading();

    try {
      Response response = await dio.post(
        "${DataConnection.connectionUrl}forgot_password/",
        data: {'email': email},
      );

      if (response.data is Map && response.data.containsKey('status')) {
        if (response.data['status'] == 200) {
          _successMessage = response.data['message'];
          stopLoading();
          return true;
        } else {
          _errorMessage = "Error: ${response.data['message']}";
          stopLoading();
          return false;
        }
      } else {
        _errorMessage = "Unexpected response format";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'].toString() ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user', _userData != null ? json.encode(_userData) : '');
    await prefs.setString('accessToken', _accessToken ?? '');
    await prefs.setString('refreshToken', _refreshToken ?? '');
    await prefs.setString('token', _bearerToken ?? '');
  }

  Future<bool> login(String email, String password) async {
    startLoading();
    try {
      Response response = await dio.post(
          "${DataConnection.connectionUrl}login/",
          data: {'email': email, 'password': password});

      if (response.data['status'] == 200) {
        var data = response.data;

        _userData = data['data'];
        // _accessToken = data['data']['profile']['user_access_token'];

        // _refreshToken = data['refresh_token'];
        // _bearerToken = data['token'];

        // // _expiresAt = DateTime.now()
        // //     .add(Duration(seconds: int.parse(data?['expires_at']))) as String?;

        // try new implementation

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'user', _userData != null ? json.encode(_userData) : '');
        await prefs.setString('refreshToken', data['refresh_token']);
        await prefs.setString('token', data['token']);

        // end try new implementation
        // saveUserData();
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message']}";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      devLog("Error: ${e.response}");

      _errorMessage =
          "Error: ${e.response?.data?['message'] ?? "Internal server error"}";
      stopLoading();
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> payload) async {
    startLoading();

    try {
      var response = await _dataConnection.postData('register/', payload);

      if (response.statusCode == 201) {
        stopLoading();
        _successMessage = "${response.data['message']}";
        return true;
      } else {
        _errorMessage =
            "Failed to register: ${response.data['message'] ?? 'Unknown error'}";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('token');

    _userData = null;
    _accessToken = null;
    _refreshToken = null;
    _expiresAt = null;
    _bearerToken = null;
    notifyListeners();
  }

  Future<bool> verifyUser(String email, String otp) async {
    startLoading();
    try {
      Response response = await dio.post(
          "${DataConnection.connectionUrl}verify/",
          data: {'email': email, 'otp': otp});

      if (response.data['status'] == 200) {
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message'] ?? 'Unkown Error'}";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<bool> resendVerificationCode(String email) async {
    startSmallLoading();
    try {
      Response response = await dio.put(
          "${DataConnection.connectionUrl}regenerate_otp/",
          data: {'email': email});

      if (response.data['status'] == 200) {
        _successMessage =
            "Success: ${response.data['message'] ?? 'Successfully resent code'}";
        stopSmallLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message'] ?? "Unknown error"}";
        stopSmallLoading();
        return false;
      }
    } on DioException catch (e) {
      stopSmallLoading();
      _errorMessage = "Network error: ${e.message}";
      stopLoading();
      return false;
    }
  }

  Future<bool> verifyPasswordOTP(String email, String otp) async {
    startLoading();
    try {
      Response response = await dio.post(
          "${DataConnection.connectionUrl}verify_password_otp/",
          data: {'email': email, 'otp': otp});

      if (response.data['status'] == 202) {
        _successMessage = response.data['message'];
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message'] ?? 'Unkown Error'}";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    startLoading();
    try {
      Response response = await dio.post(
          "${DataConnection.connectionUrl}reset_new_password/",
          data: {'email': email, 'password': password});

      if (response.data['status'] == 202) {
        _successMessage = response.data['message'];
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message'] ?? 'Unkown Error'}";
        stopLoading();
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }
}
