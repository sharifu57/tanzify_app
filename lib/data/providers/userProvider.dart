import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class UserProvider extends ChangeNotifier {
  Dio dio = Dio();
  List<dynamic> sysUsers = [];
  late DataConnection _dataConnection = DataConnection();

  UserProvider() {
    _dataConnection = DataConnection();
  }

  void startLoading() {
    notifyListeners();
  }

  void stopLoading() {
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      var response = await _dataConnection.fetchData('users/');
      // var response = await Dio().get("http://85.190.243.96:8000/API/V1/users/");

      print("=======response user =====00");
      print(response);
      print("=======end response =====00");

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
