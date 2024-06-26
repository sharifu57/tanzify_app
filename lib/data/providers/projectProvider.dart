import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
// import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class ProjectProvider extends ChangeNotifier {
  Dio dio = Dio();
  bool _isLoading = false;
  String _errorMessage = "";
  String _successMessage = "";
  late DataConnection _dataConnection = DataConnection();
  List<ProjectModal> projects = [];
  List<dynamic> myBids = [];
  List<dynamic> myProjects = [];

  ProjectProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  List<ProjectModal> get projectsList => projects;

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
    try {
      var response =
          await _dataConnection.fetchData('get_match_projects/$userCategory/');

      if (response != null) {
        var results = response['results'];

        if (results is List) {
          for (var element in results) {
            // print("Element type: ${element.runtimeType}");
            // print("Element content: $element");
          }

          projects = results
              .map((e) {
                if (e is Map<String, dynamic>) {
                  try {
                    return ProjectModal.fromJson(e);
                  } catch (e) {
                    return null; // Filter out invalid elements
                  }
                } else {
                  return null; // Filter out invalid elements
                }
              })
              .where((e) => e != null)
              .cast<ProjectModal>()
              .toList();
          notifyListeners();
          _isLoading = false;
        } else {
          // print("Results is not a list: $results");
        }
      }
    } catch (e) {
      _isLoading = false;
      // print("Error during parsing projects: $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getRecentProjects() async {
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('projects/');

      if (response != null) {
        var results = response['results'];

        if (results is List) {
          for (var element in results) {
            // print("Element type: ${element.runtimeType}");
            // print("Element content: $element");
          }

          projects = results
              .map((e) {
                if (e is Map<String, dynamic>) {
                  try {
                    return ProjectModal.fromJson(e);
                  } catch (e) {
                    // print("Error parsing project: $e");
                    return null; // Filter out invalid elements
                  }
                } else {
                  // print("Element is not a Map<String, dynamic>: $e");
                  return null; // Filter out invalid elements
                }
              })
              .where((e) => e != null)
              .cast<ProjectModal>()
              .toList();
          notifyListeners();
          _isLoading = false;
        } else {
          // print("Results is not a list: $results");
        }
      }
    } catch (e) {
      _isLoading = false;
      // print("Error during parsing projects: $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> applyProject(Map<String, dynamic> payload) async {
    startLoading();

    try {
      var response = await _dataConnection.postData('create_new_bid/', payload);

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
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<void> getMyBids(int bidderId) async {
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('my_bids/$bidderId/');

      if (response != null && response is List) {
        myBids = response;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMyProjects(int userId) async {
    print("======user end id");
    print(userId);
    print("=====end user end id");
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('my_projects/$userId/');

      print("======my projects");
      print(_dataConnection.fetchData('my_projects/$userId/'));
      print(response);
      print("====end my projects");

      if (response != null) {
        print("====respone here");
        myProjects = response['data'];
        print(myProjects);
        print("====response not null");
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createProject(Map<String, dynamic> payload) async {
    startLoading();
    try {
      var response = await _dataConnection.postData("create_project/", payload);
      if (response.data['status'] == 201) {
        stopLoading();
        _successMessage = response.data['message'];
      }

      return true;
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }
}
