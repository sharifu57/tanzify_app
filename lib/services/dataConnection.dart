import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataConnection with ChangeNotifier {
  late Dio dio;
  static const String httpBase = 'http://172.15.197.161:8005';
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
      print("Error fetching data: $e");
      return null;
    }
  }

  Future<dynamic> postData(String endpoint, data) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      print("Error posting data: $e");
      return null;
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
