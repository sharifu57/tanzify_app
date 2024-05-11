import 'package:flutter/material.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class ProjectProvider extends ChangeNotifier {
  bool _isLoading = false;
  late DataConnection _dataConnection = DataConnection();

  ProjectProvider() {
    _dataConnection = DataConnection();
  }

  bool get isLoading => _isLoading;
}
