import 'dart:convert';

import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:patient_analytics_flutter/models/api_exception.dart';
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

  Future<Result<LoginResponse, ApiException>> login(LoginPayload payload) async {
    try {
      final response = await httpClient.post('/auth/login', body: payload.toJson());

      if (response.statusCode == 200) {
        final convertedBody = LoginResponse.fromJson(response.body);
        return Success(convertedBody);
      } else {
        return Error(ApiException(response.body));
      }
    } catch (e) {
      return Error(ApiException(e));
    }
  }
}
