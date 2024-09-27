import 'dart:convert';

class LoginResponse {
  final String token;
  final String refreshToken;

  const LoginResponse({required this.token, required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'token': String token,
        'refreshToken': String refreshToken,
      } =>
        LoginResponse(token: token, refreshToken: refreshToken),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
