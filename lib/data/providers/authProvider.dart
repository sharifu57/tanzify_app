import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/services/dataConnection.dart';

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
  String? _expiresAt;

  Map<String, dynamic>? get userData => _userData;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
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

  Future<bool> login(String email, String password) async {
    startLoading();
    try {
      Response response = await dio.post(
          "${DataConnection.connectionUrl}login/",
          data: {'email': email, 'password': password});

      if (response.data['status'] == '200') {
        var data = response.data;
        _userData = data['data'];
        _accessToken = data['access_token'];
        _refreshToken = data['refresh_token'];
        // _expiresAt = DateTime.now()
        //     .add(Duration(seconds: int.parse(data?['expires_at']))) as String?;
        saveUserData();
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message']}";
        stopLoading();
        return false;
      }
    } on DioError catch (e) {
      _errorMessage = "Error: ${e.response?.data['message'] ?? e.message}";
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
        return true;
      } else {
        _errorMessage =
            "Failed to register: ${response.data['message'] ?? 'Unknown error'}";
        stopLoading();
        return false;
      }
    } on DioError catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
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
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    _userData = null;
    _accessToken = null;
    _refreshToken = null;
    _expiresAt = null;
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
    } on DioError catch (e) {
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
    } on DioError catch (e) {
      stopSmallLoading();
      _errorMessage = "Network error: ${e.message}";
      stopLoading();
      return false;
    }
  }
}
