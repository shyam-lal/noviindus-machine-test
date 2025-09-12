import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:novindus_machine_test/config/webservices/api_request.dart';
import 'package:novindus_machine_test/config/webservices/api_response.dart';
import 'package:novindus_machine_test/repositories/auth_service.dart';

class ApiClient {
  static Future<ApiResponse<T>?> postData<T>({
    required ApiRequest request,
    required T Function(dynamic) fromJson,
    bool? needsHeader,
  }) async {
    try {
      final token = AuthService().token;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (token != null && (needsHeader ?? true)) 'Authorization': 'Bearer $token',
        ...?request.headers,
      };

      final response = await http.post(
        request.url!,
        body: jsonEncode(request.body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return ApiResponse(data: fromJson(jsonResponse));
      } else {
        return ApiResponse(error: "HTTP ERROR ${response.statusCode}");
      }
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
