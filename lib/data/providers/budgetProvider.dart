import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/models/budget/budgetModal.dart';
import 'package:tanzify_app/services/dataConnection.dart';

class BudgetProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;
  List<BudgetModal> budgets = [];
  late DataConnection _dataConnection;

  BudgetProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _dataConnection = DataConnection();
    await getBudgets();
  }

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<BudgetModal> get budgetList => budgets;

  Future<void> getBudgets() async {
    print("=======budgets");
    _isLoading = true;
    try {
      var response = await _dataConnection.fetchData('budgets/');
      print("=====response budgets");
      if (response != null) {
        budgets = (response as List)
            .map((budget) => BudgetModal.fromJson(budget))
            .toList();

        _isLoading = false;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      print("=====somethis ooops: ${e.toString()}");
      _isLoading = false;
      notifyListeners();
    }
  }
}
