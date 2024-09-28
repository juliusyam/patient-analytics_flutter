import 'package:patient_analytics_flutter/models/user.dart';

class LoginResponse {
  final String token;
  final String refreshToken;
  final User user;

  const LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'token': String token,
        'refreshToken': String refreshToken,
        'user': Map<String, dynamic> user,
      } => LoginResponse(token: token, refreshToken: refreshToken, user: User.fromJson(user)),
      _ => throw const FormatException('Failed to covert LoginResponse'),
    };
  }
}
