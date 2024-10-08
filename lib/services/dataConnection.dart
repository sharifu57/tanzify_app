import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/services/userService.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  bool isProduction = false;
  late Map<String, dynamic>? userData;
  String? accessToken;
  String? refreshToken;
  bool _isInitialized = false;

  static const String httpBase = 'http://85.190.243.96:8000';
  // static const String httpBase = 'http://192.168.0.166:8000';

  static const String connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    _initialize();
  }

  Future<void> _refreshToken() async {
    try {
      final response = await dio.post('$httpBase/api/token/refresh/',
          data: {'refresh': refreshToken});
      print(response.data['access']);

      if (response.data['access'] || response.statusCode == 200) {
        accessToken = response.data['access'];
        refreshToken = response.data['refresh'];
        await UserService.saveUserBearerToken(accessToken);
        await UserService.saveUserRefreshToken(refreshToken);
        notifyListeners();
      }
    } catch (e) {
      print("=======Error Response: ${e}");
    }
  }

  Future<Response> _retryRequest(
      Future<Response> Function() requestFunction) async {
    try {
      print("=====retyr connection");
      return await requestFunction();
    } on DioError catch (e) {
      print("=====error connection");
      print(e.response);
      print(e.response?.statusCode);
      print(e.response?.data);
      print("=======end print error response");
      if (e.response?.statusCode == 401) {
        await _refreshToken(); // Try to refresh the token
        return await requestFunction(); // Retry the original request
      } else {
        rethrow;
      }
    }
  }

  Future<void> _initialize() async {
    final bearerToken = await UserService.getUserbearerToken();
    final userRefreshToken = await UserService.getUserRefreshToken();

    print("===========token n refresh token===========");
    print(bearerToken);
    print(userRefreshToken);
    print("===========end token n refresh token===========");

    if (bearerToken != null) {
      accessToken = bearerToken;
    }

    if (userRefreshToken != null) {
      refreshToken = userRefreshToken;
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _ensureInitialized() async {
    while (!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Map<String, dynamic> _getHeaders({bool includeToken = true}) {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (includeToken && accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  Future<dynamic> fetchData(String endpoint, {bool includeToken = true}) async {
    await _ensureInitialized();
    // return await _retryRequest(() async {
    //   final response = await dio.get(endpoint,
    //       options: Options(headers: _getHeaders(includeToken: includeToken)));
    //   return response.data;
    // });
    final response = await dio.get(endpoint,
        options: Options(headers: _getHeaders(includeToken: includeToken)));
    return response.data;
  }

  Future<dynamic> fetchData1(String endpoint) async {
    final response = await dio.get(endpoint);

    return response.data;
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> payload,
      {bool includeToken = true}) async {
    await _ensureInitialized();
    return await _retryRequest(() async {
      return await dio.post(endpoint,
          data: payload,
          options: Options(headers: _getHeaders(includeToken: includeToken)));
    });
  }

  Future<Response> updateData(String endpoint,
      {bool includeToken = true}) async {
    try {
      Response response = await dio.put(endpoint,
          options: Options(headers: _getHeaders(includeToken: includeToken)));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
