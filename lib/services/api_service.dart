import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:patient_analytics_flutter/models/api_exception.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';
import 'package:patient_analytics_flutter/models/auth/login_response.dart';
import 'package:patient_analytics_flutter/models/patient.dart';

class ApiService extends GetConnect {
  final String? token;
  ApiService({ required this.token });

  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8080/api';

    httpClient.addRequestModifier<void>((request) async {
      print("Token received: $token");
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
        final data = LoginResponse.fromJson(response.body);
        return Success(data);
      } else {
        return Error(ApiException(response.body));
      }
    } catch (e) {
      return Error(ApiException(e));
    }
  }

  Future<Result<List<Patient>, ApiException>> getPatients() async {
    try {
      final response = await httpClient.get('/patients');

      print(response.statusCode);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final List list = response.body;
        final List<Patient> data = list.map((item) => Patient.fromJson(item)).toList();
        return Success(data);
      } else {
        return Error(ApiException(response.body));
      }
    } catch (e) {
      return Error(ApiException(e));
    }
  }
}
