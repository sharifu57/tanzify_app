import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class AuthProvider with ChangeNotifier {
  Dio dio = Dio();
  String _errorMessage = "";
  bool _isLoading = false;
  late DataConnection _dataConnection;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

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

    print("=======payload");
    print(payload);
    print("======end payload");

    try {
      var response = await _dataConnection.postData('register/', payload);

      print("=======register response + $response =====");
      stopLoading();
      return true;
    } catch (e) {
      stopLoading();
      print(e);
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
}
