import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  String? _token;
  String? _refreshToken;
  User? _user;

  String? get token => _token;
  String? get refreshToken => _refreshToken;
  User? get user => _user;

  void updateUser(String token, String refreshToken, User user) {
    _token = token;
    _refreshToken = refreshToken;
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _token = null;
    _refreshToken = null;
    _user = null;
    notifyListeners();
  }
}
