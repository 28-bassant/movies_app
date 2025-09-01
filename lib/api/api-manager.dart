import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/api-endpoints.dart';
import 'package:movies_app/model/movie_suggestions_response.dart';
import 'package:movies_app/model/register_response.dart';
import '../app-prefrences/token-storage.dart';
import '../model/login-response.dart';
import '../model/movie_details_response.dart';
import 'api-constant.dart';

class ApiManager {
  static Future<LoginResponse> login(String email, String password) async {
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.login}");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    print('AUTH ===> ${response.body}');

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await TokenStorage.saveToken(responseData['data']);
      return LoginResponse.fromJson(responseData);
    } else {
      throw Exception(responseData["message"] ?? "Login failed, try again.");
    }
  }

  static Future<void> restPassword(
      String newPassword, String confirmPassword) async {}

  static Future<UserData> fetchProfile(String token) async {
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.profile}");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('PROFILE ===> ${response.body}');

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserData.fromJson(responseData['data']);
    } else {
      throw Exception(
          responseData["message"] ?? "Failed to load profile data.");
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

  static Future<void> updateProfile(
      String? name, String? phone, int? avaterId) async {
    final Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.profile}");
    final updatedValues = <String, dynamic>{};
    if (name != null) updatedValues['name'] = name;
    if (phone != null) updatedValues['phone'] = phone;
    if (avaterId != null) updatedValues['avatarId'] = avaterId;

    try {
      final token = await TokenStorage.getToken();
      print('TOKEN => $token');
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(updatedValues),
      );

      print('====== UPDATE PROFILE API ======');
      if (response.statusCode == 200) {
        print("Profile updated successfully");
        print("Response: ${response.body}");
      } else {
        print("Failed to update: ${response.statusCode}");
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  static Future<void> deleteAccount() async {
    final token = await TokenStorage.getToken();
    Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.profile}");

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

  static Future<MovieDetailsResponse?> getMovieDetailsByMovieId(num movieId) async {
    Uri url = Uri.https(
      ApiConstants.movieDetailsBaseUrl,
      ApiEndpoints.movieDetails,
      {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        'with_cast': 'true',
      },
    );

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieDetailsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

}
