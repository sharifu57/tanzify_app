import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class ProjectProvider extends ChangeNotifier {
  Dio dio = Dio();
  bool _isLoading = false;
  String _errorMessage = "";
  late DataConnection _dataConnection = DataConnection();
  List<ProjectModel> projects = [];

  ProjectProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ProjectModel> get projectsList => projects;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProjects(int userCategory) async {
    _isLoading = true;
    print("-------category Id");
    print(userCategory);
    print("=======end category id");

    // notifyListeners();
    try {
      var response =
          await _dataConnection.fetchData('get_match_projects/$userCategory/');
      print("Raw response data: $response");

      // Checking if the response is a Map and contains 'results'
      if (response != null) {
        if (response is Map<String, dynamic> &&
            response.containsKey('results')) {
          var results = response['results'];

          if (results is List) {
            // Parsing each project in the results list

            projects = results
                .map((e) => e != null
                    ? ProjectModel.fromJson(e as Map<String, dynamic>)
                    : null)
                .where((e) => e != null)
                .cast<ProjectModel>()
                .toList();
          }
        } else {
          print("=============response is null");
        }
      }
    } catch (e) {
      print("Error during parsing: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> applyProject(Map<String, dynamic> payload) async {
    startLoading();

    try {
      var response = await _dataConnection.postData('create_new_bid/', payload);

      // print("====================bid response");
      // print(response.data['status']);
      // print("=================end bid response");

      if (response.data['status'] == 201) {
        stopLoading();

        _errorMessage = response.data['message'];

        return true;
      } else {
        _errorMessage =
            "Failed to send Bid request: ${response.data['message']}";
        stopLoading();
        return false;
      }
    } on DioError catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }
}
