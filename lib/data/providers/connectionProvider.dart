import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;

  ConnectivityResult get connectivityStatus => _connectivityStatus;

  ConnectivityService() {
    _initializeConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>?;
  }

  Future<void> _initializeConnectivity() async {
    try {
      _connectivityStatus = (await _connectivity.checkConnectivity()) as ConnectivityResult;
      notifyListeners();
    } catch (e) {
      print("Couldn't check connectivity status: $e");
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectivityStatus = result;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
