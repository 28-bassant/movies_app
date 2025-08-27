import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/api-endpoints.dart';
import 'package:movies_app/model/register_response.dart';
import '../app-prefrences/token-storage.dart';
import '../model/login-response.dart';
import 'api-constant.dart';

class ApiManager {
  static Future<LoginResponse> login(String email, String password) async {
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.login}");
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

  static Future<RegisterResponse> register(
      String email,
      String name,
      String password,
      String confirmPassword,
      String phone,
      int avaterId,
      ) async {
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.register}");

    var data = {
      "email": email,
      "name": name,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phone,
      "avaterId": avaterId,
    };

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return RegisterResponse.fromJson(json);
      } else {
        var json = jsonDecode(response.body);
        throw Exception(json["message"] ?? "Registration failed");
      }
    } catch (e) {
      throw Exception("Error while registering: $e");
    }
  }

  static Future<void> deleteAccount() async {
    final token = await TokenStorage.getToken();
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.deleteProfile}");

    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("DELETE ACCOUNT STATUS: ${response.statusCode}");
    print("DELETE ACCOUNT BODY: ${response.body}");

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print("Account Deleted: ${responseJson['message']}");
    } else {
      throw Exception("Failed to delete account: ${response.body}");
    }
  }

}
