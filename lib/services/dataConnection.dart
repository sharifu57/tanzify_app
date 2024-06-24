import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  bool isProduction = false;

  // static const String httpBase = 'http://109.199.108.165';
  static const String httpBase = 'http://192.168.1.63:8005';

  static const String connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);

      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postData(
      String endpoint, Map<String, dynamic> payload) async {
    try {
      Response response = await dio.post(endpoint, data: payload);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
