import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;

  static const connectionUrl = "http://localhost:8005/api/v1/";
  DataConnection() {
    dio = Dio(BaseOptions(
        // connectTimeout: 5000,
        // receiveTimeout: 3000,
        baseUrl: connectionUrl));

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
