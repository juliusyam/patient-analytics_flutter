import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patient_analytics_flutter/models/enums/role.dart';
import 'package:patient_analytics_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  final box = GetStorage();

  String? _token;
  String? _refreshToken;
  User? _user;

  String? get token => _token;
  String? get refreshToken => _refreshToken;
  User? get user => _user;

  UserProvider() {
    _token = box.read('token');
    _refreshToken = box.read('refreshToken');

    final userString = box.read('user_string');
    if (userString != null) {
      _user = User.fromJson(jsonDecode(userString));
    }
  }

  void updateUser(String token, String refreshToken, User user) {
    _token = token;
    box.write('token', token);

    _refreshToken = refreshToken;
    box.write('refresh_token', refreshToken);

    _user = user;
    box.write('user_string', user.toJson());

    _redirectUser();
    notifyListeners();
  }

  void removeUser() {
    _token = null;
    box.remove('token');

    _refreshToken = null;
    box.remove('refresh_token');

    _user = null;
    box.remove('user_string');

    _redirectUser();
    notifyListeners();
  }

  void _redirectUser() {

    if (_user?.role != null) {
      switch (_user!.role) {
        case Role.SuperAdmin:
        case Role.Admin:
          Modular.to.navigate('/admin-dashboard');
        case Role.Doctor:
          Modular.to.navigate('/doctor-dashboard');
      }
    } else {
      Modular.to.navigate('/');
    }
  }
}
