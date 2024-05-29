import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/models/Bid/bidModal.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class ProjectProvider extends ChangeNotifier {
  Dio dio = Dio();
  bool _isLoading = false;
  String _errorMessage = "";
  late DataConnection _dataConnection = DataConnection();
  List<ProjectModel> projects = [];
  List<BidModal> myBids = [];

  ProjectProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ProjectModel> get projectsList => projects;
  List<BidModal> get bidsList => myBids;

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

      // Print the response to debug its structure
      print(response);

      // Checking if the response is a Map and contains 'results'
      if (response != null && response is Map<String, dynamic>) {
        var results = response['results'];

        if (results is List) {
          // Parsing each project in the results list
          projects = results
              .where((e) =>
                  e is Map<String, dynamic>) // Ensure each element is a map
              .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          print("Results is not a list");
        }
      } else {
        print("Response is not a map or does not contain 'results'");
      }
    } catch (e) {
      print("Error during parsing projects: $e");
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

  Future<void> getMyBids(int bidderId) async {
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('my_bids/$bidderId/');

      if (response != null && response is List) {
        print("===========my response bid");
        print(response);
        print("=========end my response bid");

        myBids = response
            .where((e) =>
                e is Map<String, dynamic>) // Ensure each element is a map
            .map((e) => BidModal.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print("Error during parsing my bids: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
