import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/services/userService.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  bool isProduction = false;
  late Map<String, dynamic>? userData;
  String? accessToken;
  bool _isInitialized = false;

  static const String httpBase = 'http://85.190.243.96:8000';
  // static const String httpBase = 'http://172.23.176.1:8005';

  static const String connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    // Initialize and fetch the user data from local storage
    _initialize();
  }

  Future<void> _initialize() async {
    final bearerToken = await UserService.getUserbearerToken();

    if (bearerToken != null) {
      accessToken = bearerToken;
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _ensureInitialized() async {
    while (_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Map<String, dynamic> _getHeaders() {
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  Future<dynamic> fetchData(String endpoint) async {
    await _ensureInitialized();

    try {
      final response =
          await dio.get(endpoint, options: Options(headers: _getHeaders()));

      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postData(
      String endpoint, Map<String, dynamic> payload) async {
    await _ensureInitialized();
    try {
      Response response = await dio.post(endpoint,
          data: payload, options: Options(headers: _getHeaders()));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateData(String endpoint) async {
    try {
      Response response =
          await dio.put(endpoint, options: Options(headers: _getHeaders()));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
