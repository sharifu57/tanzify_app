import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class CategoryProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;
  List<CategoryModel> categories = [];
  List<SkillModel> skills = [];
  late DataConnection _dataConnection;

  CategoryProvider() {
    _dataConnection = DataConnection();
  }

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<CategoryModel> get categoryList => categories;
  List<SkillModel> get skillList => skills;

  Future<void> getCategories() async {
    _isLoading = true;
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

  Future<List<SkillModel>> getSkillsBycategoryId(String categoryId) async {
    try {
      var response = await _dataConnection.fetchData('skills/$categoryId/');

      if (response != null) {
        var skills =
            (response as List).map((e) => SkillModel.fromJson(e)).toList();

        return skills;
      }
      return [];
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    }
  }
}
