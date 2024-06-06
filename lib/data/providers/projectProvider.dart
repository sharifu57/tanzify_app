import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/models/Bid/bidModal.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
// import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class ProjectProvider extends ChangeNotifier {
  Dio dio = Dio();
  bool _isLoading = false;
  String _errorMessage = "";
  late DataConnection _dataConnection = DataConnection();
  List<ProjectModal> projects = [];
  List<BidModal> myBids = [];

  ProjectProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ProjectModal> get projectsList => projects;
  List<BidModal> get bidsList => myBids;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // List<Map<String, dynamic>> convertStringsToNums(List<dynamic> items) {
  //   return items.map((item) {
  //     if (item is Map<String, dynamic>) {
  //       return item.map((key, value) {
  //         if (value is Map<String, dynamic> ) {
  //           return MapEntry(key, convertStringsToNums([value]).first);
  //         } else if (value is List) {
  //           return MapEntry(key, convertStringsToNums(value));
  //         } else if (value is String &&
  //             (key == 'price_from' || key == 'price_to' || key == 'amount')) {
  //           final numValue = double.tryParse(value);
  //           return MapEntry(key, numValue ?? value);
  //         } else {
  //           return MapEntry(key, value);
  //         }
  //       });
  //     }
  //     return item as Map<String, dynamic>;
  //   }).toList();
  // }

  // List<Map<String, dynamic>> convertStringsToNums(List<dynamic> items) {
  //   return items.map((item) {
  //     if (item is Map<String, dynamic>) {
  //       return item.map((key, value) {
  //         if (value is Map<String, dynamic>) {
  //           return MapEntry(key, convertStringsToNums([value]).first);
  //         } else if (value is List) {
  //           return MapEntry(key, convertStringsToNums(value));
  //         } else if (value is int) {
  //           return MapEntry(key, value.toString());
  //         } else {
  //           return MapEntry(key, value);
  //         }
  //       });
  //     }
  //     return item as Map<String, dynamic>;
  //   }).toList();
  // }

  List<Map<String, dynamic>> convertStringsToNums(List<dynamic> items) {
    print("------inside");
    return items.map((item) {
      if (item is Map<String, dynamic>) {
        print("======value map string to dynamic");
        return item.map((key, value) {
          if (value is Map<String, dynamic>) {
            return MapEntry(key, convertStringsToNums([value]).first);
          } else if (value is List) {
            return MapEntry(key, convertStringsToNums(value));
          } else if (value is String &&
              (key == 'price_from' || key == 'price_to' || key == 'amount')) {
            final numValue = double.tryParse(value);
            return MapEntry(key, numValue ?? value);
          } else if (value is int) {
            // Handle integer values here
            return MapEntry(key, convertIntsToStrings([value]).first);
          } else {
            // Handle other types here
            return MapEntry(key, value);
          }
        });
      }
      return item as Map<String, dynamic>;
    }).toList();
  }

  List<Map<String, dynamic>> convertIntsToStrings(List<dynamic> items) {
    return items.map((item) {
      if (item is Map<String, dynamic>) {
        return item.map((key, value) {
          if (value is Map<String, dynamic>) {
            return MapEntry(key, convertIntsToStrings([value]).first);
          } else if (value is List) {
            return MapEntry(key, convertIntsToStrings(value));
          } else if (value is int) {
            return MapEntry(key, value.toString());
          } else {
            return MapEntry(key, value);
          }
        });
      }
      return item as Map<String, dynamic>;
    }).toList();
  }

  bool containsEnums(List<dynamic> items) {
    print("=====this is enum");
    for (var item in items) {
      print("=====loop1");
      if (item is Map<String, dynamic>) {
        print("======item: ${item}");
        // Check each key-value pair for enums
        for (var value in item.values) {
          print("______value: ${value}");
          if (value is String) {
            return true;
          }
        }
      }
    }
    return false;
  }

// Function to check if a string represents an enum
  bool isEnum(String value) {
    // Implement your logic here to determine if the string represents an enum
    // For example, you could check if the string matches known enum values
    return value == 'enumValue1' ||
        value == 'enumValue2'; // Replace with actual enum values
  }

  Future<void> getProjects(int userCategory) async {
    _isLoading = true;
    try {
      print("-----step 1");
      var response =
          await _dataConnection.fetchData('get_match_projects/$userCategory/');
      print("----step 2");

      if (response != null) {
        print("Response: $response");

        var results = response['results'];
        print("=====results");
        print(results);

        if (results is List) {
          results.forEach((element) {
            print("Element type: ${element.runtimeType}");
            print("Element content: $element");
          });

          projects = results
              .map((e) {
                if (e is Map<String, dynamic>) {
                  try {
                    return ProjectModal.fromJson(e);
                  } catch (e) {
                    print("Error parsing project: $e");
                    return null; // Filter out invalid elements
                  }
                } else {
                  print("Element is not a Map<String, dynamic>: $e");
                  return null; // Filter out invalid elements
                }
              })
              .where((e) => e != null)
              .cast<ProjectModal>()
              .toList();
            notifyListeners();
            _isLoading = false;
        } else {
          print("Results is not a list: $results");
        }

        print("=====here projects");
        print(projects);
        print("====end here projects");
      }
    } catch (e) {
      _isLoading = false;
      print("Error during parsing projects: $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Future<void> getProjects(int userCategory) async {
  //   _isLoading = true;
  //   try {
  //     var response =
  //         await _dataConnection.fetchData('get_match_projects/$userCategory/');

  //     print("====before response: " + response);

  //     // Print the response to debug its structure
  //     print(response);

  //     // Checking if the response is a Map and contains 'results'
  //     if (response != null && response is Map<String, dynamic>) {
  //       print("============response is a Map");
  //       var results = response['results'];

  //       // Check if results is a list
  //       if (results is List) {
  //         // Check if enums are present in the response
  //         bool hasEnums = containsEnums(results);

  //         // Convert the list based on the presence of enums
  //         List<Map<String, dynamic>> convertedResults;
  //         if (hasEnums) {
  //           print("=========has enums");
  //           convertedResults = convertStringsToNums(results);
  //         } else {
  //           print("=========no enums");
  //           convertedResults = convertIntsToStrings(results);
  //         }

  //         // Ensure that each element is properly cast as a Map<String, dynamic>
  //         projects =
  //             convertedResults.map((e) => ProjectModel.fromJson(e)).toList();
  //       }
  //     } else {
  //       print("Response is not a map or does not contain 'results'");
  //     }
  //   } catch (e) {
  //     print("Error during parsing projects: $e");
  //     _errorMessage = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

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
