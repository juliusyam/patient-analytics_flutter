import 'dart:convert';

class LoginPayload {
  LoginPayload(this.username, this.password);
  String username = '';
  String password = '';

  String toJson() {
    return jsonEncode({
      'username': username,
      'password': password,
    });
  }
}
