import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  static const httpBase = 'http://172.20.10.3:8005';
  static const connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    // Adding an interceptor for logging HTTP requests and responses
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
