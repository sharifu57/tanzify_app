import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Dio dio = Dio();

  String _errorMessage = "";
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

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
      Response response = await dio.post("http://localhost:8005/api/v1/login",
          data: {email: email, password: password});

      if (response.statusCode == 200) {
        stopLoading();
        return true;
      } else {
        _errorMessage = "Error: ${response.data['message']}";
        stopLoading();
        return false;
      }
    } on DioError catch (e) {
      _errorMessage = e.message!;
      stopLoading();
      return false;
    }
  }
}
