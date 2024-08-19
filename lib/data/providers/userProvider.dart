import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class UserProvider extends ChangeNotifier {
  Dio dio = Dio();
  List<dynamic> sysUsers = [];
  bool _isLoading = false;
  late DataConnection _dataConnection = DataConnection();

  UserProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUsers() async {
    startLoading();
    try {
      var response = await _dataConnection.fetchData('users/');

      print("=======response users =====00");
      print(response);
      print("=======end response =====00");

      if (response != null) {
        sysUsers = response['data'];
        stopLoading();
      } else {
        print("No response received.");
        stopLoading();
      }
    } catch (e) {
      print("An error occurred: $e");
      stopLoading();
    }
  }
}
