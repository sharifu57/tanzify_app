import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/models/duration/durationModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class DurationProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;
  List<DurationModal> durations = [];
  late DataConnection _dataConnection;

  DurationProvider() {
    _dataConnection = DataConnection();
  }

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<DurationModal> get durationList => durations;

  Future<void> getDurations() async {
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('durations/');

      if (response != null) {
        durations = (response as List)
            .map((duration) => DurationModal.fromJson(duration))
            .toList();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
