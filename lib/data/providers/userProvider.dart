import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class UserProvider extends ChangeNotifier {
  Dio dio = Dio();
  bool _isLoading = false;
  String _errorMessage = "";
  String _successMessage = "";
  List<dynamic> sysUsers = [];
  late DataConnection _dataConnection = DataConnection();

  UserProvider() {
    _dataConnection = DataConnection();
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      var response = await _dataConnection.fetchData('users/');

      if (response != null) {
        sysUsers = response['data'];
      } else {
        print("No response received.");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
