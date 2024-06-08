import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/models/location/locationModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class LocationProvider extends ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;
  List<LocationModal> locations = [];
  late DataConnection _dataConnection;

  LocationProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _dataConnection = DataConnection();
    await getLocations();
  }

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<LocationModal> get locationList => locations;

  Future<void> getLocations() async {
    _isLoading = true;
    notifyListeners();
    try {
      var response = await _dataConnection.fetchData('locations/');
      if (response != null) {
        if (response is Map<String, dynamic> && response['data'] is List) {
          locations = (response['data'] as List)
              .map((location) => LocationModal.fromJson(location))
              .toList();
        } else if (response is List) {
          locations = response
              .map((location) => LocationModal.fromJson(location))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      print("====== something is not okay: ${e.toString()}");
      notifyListeners();
    }
  }
}
