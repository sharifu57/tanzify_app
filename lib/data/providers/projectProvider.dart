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
  List<dynamic> bidders = [];
  List<dynamic> systemProjects = [];

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
    print("========best match");
    print(userCategory);
    print("========end best match");
    _isLoading = true;
    try {
      var response = await _dataConnection
          .fetchData('get_match_projects/$userCategory/', includeToken: true);

      print("====response here");
      print(response);
      print("=======end response");

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
      print("Error during parsing projects: $e");
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
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('my_projects/$userId/');

      if (response != null) {
        myProjects = response['data'];
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
      var response = await _dataConnection.postData("create_project/", payload,
          includeToken: true);
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

  Future<void> getProjectBidders(String projectId) async {
    _isLoading = true;
    try {
      var response =
          await _dataConnection.fetchData('project_bidders/$projectId/');

      if (response['status'] == 200) {
        _isLoading = false;
        bidders = response['data'];
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSystemProjects() async {
    startLoading();
    try {
      var response = await _dataConnection.fetchData('system_projects/');
      if (response != null) {
        systemProjects = response['results'];

        stopLoading();
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      stopLoading();
    }
  }

  Future<bool> updateProject(String projectId, String projectStatus) async {
    startLoading();
    print("Project ID: $projectId");
    print("Project Status: $projectStatus");

    String projectStatusString = projectStatus.toString();
    try {
      var response = await _dataConnection
          .updateData('update_project_status/$projectId/$projectStatusString/');

      if (response.data['status'] == 200) {
        _successMessage = response.data['message'];
        return true;
      } else {
        _errorMessage = response.data['message'];
        return false;
      }
    } on DioException catch (e) {
      _errorMessage =
          "Network error: ${e.response?.data['message'] ?? e.message}";
      stopLoading();
      return false;
    }
  }

  Future<void> fetchMoreProjects(int pageSize, int currentPage) async {
    _isLoading = true;
    notifyListeners();

    print("======pagination");
    print(currentPage);
    print(pageSize);
    print("system_projects?page=$currentPage&limit=$pageSize");
    print("=======end pagination");

    try {
      var response = await _dataConnection
          .fetchData('system_projects/?page=$currentPage&page_size=$pageSize');
      if (response != null) {
        var results = response['data'];

        if (results is List) {
          var newProjects = results
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

          systemProjects.addAll(newProjects);
          notifyListeners();
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
