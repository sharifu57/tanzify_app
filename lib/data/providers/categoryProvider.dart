import 'package:dio/dio.dart';
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
    print("=========print categoryList========");

    _isLoading = true;
    try {
      var response =
          await _dataConnection.fetchData('categories/', includeToken: false);

      print("=======******=====");
      print(response);
      print("=====******======");

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
    print("========selected category");
    print(categoryId);
    print("=======end of selected category");

    try {
      var response = await _dataConnection.fetchData('skills/$categoryId/',
          includeToken: true);

      print("========skills response");
      print(response);
      print("========end of skills selected");

      if (response != null) {
        var skills =
            (response as List).map((e) => SkillModel.fromJson(e)).toList();

        print("=========print skills========");
        print(skills);
        print("=====******end skills======");

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
