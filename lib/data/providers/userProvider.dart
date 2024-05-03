import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String _name = "Sharifu";

  String get name => _name;
  set name(String NewName) {
    _name = NewName;
    notifyListeners();
  }
}
