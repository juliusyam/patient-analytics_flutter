import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  void updateUser(String token) {
    _token = token;
    notifyListeners();
  }

  void removeUser() {
    _token = null;
    notifyListeners();
  }
}
