import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/models/categoryModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class CategoryProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;
  List<CategoryModel> categories = [];
  late DataConnection _dataConnection;

  CategoryProvider() {
    _dataConnection = DataConnection();
  }

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<CategoryModel> get categoryList => categories;

  Future<void> getCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      var response = await _dataConnection.fetchData('categories/');

      if (response != null) {
        categories =
            (response as List).map((e) => CategoryModel.fromJson(e)).toList();

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
