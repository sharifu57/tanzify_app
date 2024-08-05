import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  bool isProduction = false;

  static const String httpBase = 'http://85.190.243.96';
  // static const String httpBase = 'http://172.23.176.1:8005';

  static const String connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  Map<String, dynamic> headers = {
    'Authorization': 'Bearer access_token',
    'Content-Type': 'application/json',
  };

  Future<dynamic> fetchData(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      final response =
          await dio.get(endpoint, options: Options(headers: headers));

      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> payload,
      {Map<String, dynamic>? headers}) async {
    try {
      Response response = await dio.post(endpoint,
          data: payload, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateData(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      Response response =
          await dio.put(endpoint, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
