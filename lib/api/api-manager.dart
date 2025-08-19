import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/api-endpoints.dart';
import '../model/login-response.dart';
import 'api-constant.dart';

class ApiManager {
  static Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.login}");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(responseData);
    } else {
      throw Exception(responseData["message"] ?? "Login failed, try again.");
    }
  }
}