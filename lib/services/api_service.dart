import 'dart:convert';

import 'package:get/get.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';
import 'package:patient_analytics_flutter/models/auth/login_response.dart';

class ApiService extends GetConnect {
  final String? token;
  ApiService({ required this.token });

  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8080/api';

    httpClient.addRequestModifier<void>((request) async {
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json';
      }
      return request;
    });
  }

  Future<LoginResponse?> login(LoginPayload payload) async {
    try {
      final response = await httpClient.post('/auth/login', body: payload.toJson());

      if (response.statusCode == 200) {
        final convertedBody = LoginResponse.fromJson(response.body);
        print('Token: ${convertedBody.token}');
        print('RefreshToken: ${convertedBody.token}');
        return convertedBody;
      } else {
        throw Exception('Failed to convert');
      }

    } catch (e) {
      print('API call failed: $e');
      return null;
    }
  }
}
