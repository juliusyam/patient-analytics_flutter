import 'dart:convert';

class LoginPayload {
  String username = '';
  String password = '';

  String toJson() {
    return jsonEncode({
      'username': username,
      'password': password,
    });
  }
}
