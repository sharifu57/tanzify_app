import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  static const String httpBase = 'http://192.168.1.147:8005';
  static const String connectionUrl = "$httpBase/API/V1/";

  DataConnection() {
    dio = Dio(BaseOptions(
      baseUrl: connectionUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));
  }

  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response.data;
    } catch (e) {
      print("Error fetching data: $e");
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





// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class DataConnection with ChangeNotifier {
//   late Dio dio;
//   static const httpBase = 'http://192.168.43.229:8005';
//   static const connectionUrl = "$httpBase/API/V1/";

//   DataConnection() {
//     dio = Dio(BaseOptions(
//       baseUrl: connectionUrl,
//       connectTimeout: const Duration(seconds: 5),
//       receiveTimeout: const Duration(seconds: 3),
//     ));

//     dio.interceptors.add(LogInterceptor(responseBody: true));
//   }

//   Future<dynamic> fetchData(String endpoint) async {
//     try {
//       final response = await dio.get(endpoint);

//       return response.data;
//     } catch (e) {
//       return null;
//     }
//   }
// }
