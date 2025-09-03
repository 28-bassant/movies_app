import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/api-endpoints.dart';
import 'package:movies_app/model/register_response.dart';
import '../app-prefrences/token-storage.dart';
import '../model/favourite_movies.dart';
import '../model/login-response.dart';
import '../model/movie_details_response.dart';
import '../utils/app_colors.dart';
import '../utils/toast_utils.dart';
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
      var rawMessage = responseData["message"];

      String errorMessage;
      if (rawMessage is List) {
        errorMessage = rawMessage.join(", ");
      } else if (rawMessage is String) {
        errorMessage = rawMessage;
      } else {
        errorMessage = "Login failed, try again.";
      }
      if (errorMessage.contains("must be strong")) {
        errorMessage = "Password is incorrect";
      } else if (errorMessage.contains("not found")) {
        errorMessage = "User not found";
      }

      throw Exception(errorMessage);
    }
  }

  static Future<void> restPassword(String newPassword,
      String confirmPassword) async {}

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

  static Future<RegisterResponse> register(String email,
      String name,
      String password,
      String confirmPassword,
      String phone,
      int avaterId,) async {
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

  static Future<void> updateProfile(String? name, String? phone,
      int? avaterId) async {
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

  static Future<MovieDetailsResponse?> getMovieDetailsByMovieId(
      num movieId) async {
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

  static List<MovieDetails> favouriteMoviesList = [];

  static Future<void> addMovieToFavourite(MovieDetails movieDetails) async {
    Uri url = Uri.https(ApiConstants.BaseUrl, ApiEndpoints.addMovieToFavourite);

    try {
      final token = await TokenStorage.getToken();

      if (token == null) {
        print("No token found. Please login first.");
        return;
      }

      print("📡 Sending add favorite request for ${movieDetails.title}");

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'movieId': movieDetails.id.toString(),
          'name': movieDetails.title,
          'rating': movieDetails.rating,
          'imageURL': movieDetails.url,
          'year': movieDetails.year.toString(),
        }),
      );

      print("StatusCode: ${response.statusCode}, Body: ${response.body}");
      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        favouriteMoviesList.add(movieDetails);
        ToastUtils.ShowToast(
            msg: "Movie added to wishlist successfully",
            bgColor: AppColors.orangeColor,
            textColor: AppColors.whiteColor);
      }
      else {
        ToastUtils.ShowToast(
            msg: " Failed: ${json['message'] ?? 'Unknown error'}",
            bgColor: AppColors.orangeColor,
            textColor: AppColors.whiteColor);
      }
    } catch (e) {
      ToastUtils.ShowToast(
          msg: "Error adding to favorites: $e",
          bgColor: AppColors.orangeColor,
          textColor: AppColors.whiteColor);
    }
  }


  static Future<void> removeMovieFromFavourite(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.BaseUrl,
      "${ApiEndpoints.removeMovieFromFavourite}/$movieId",
    );

    try {
      final token = await TokenStorage.getToken();

      if (token == null) {
        print("No token found. Please login first.");
        return;
      }

      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        ToastUtils.ShowToast(
            msg: " Movie removed from wishlist successfully",
            bgColor: AppColors.orangeColor,
            textColor: AppColors.whiteColor);
      } else {
        await ToastUtils.ShowToast(
            msg: "Failed to remove movie. Status: ${response.statusCode}",
            bgColor: AppColors.orangeColor,
            textColor: AppColors.whiteColor);
      }
    } catch (e) {
      await ToastUtils.ShowToast(
          msg: "Exception while removing movie: $e",
          bgColor: AppColors.orangeColor,
          textColor: AppColors.whiteColor);
    }
  }

  static Future<bool> isFavourite(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.BaseUrl,
      "${ApiEndpoints.isFavourite}/$movieId",
    );

    try {
      final token = await TokenStorage.getToken();

      if (token == null) {
        print("No token found. Please login first.");
        return false;
      }

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey("data")) {
          return jsonResponse["data"] as bool;
        } else {
          print("Response does not contain 'data' field.");
          return false;
        }
      } else {
        print(
            "Failed to fetch favourite status. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Exception while checking favourite: $e");
      return false;
    }
  }


  static Future<List<FavouriteMovies>> getAllFavouriteMovies() async {
    Uri url = Uri.https(ApiConstants.BaseUrl, ApiEndpoints.getAllFavouriteMovies);

    try {
      final token = await TokenStorage.getToken();
      if (token == null) return [];

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'] ?? [];

        return data.map((json) => FavouriteMovies.fromJson(json)).toList();
      } else {
        print("Failed to fetch favorites: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception while fetching favorites: $e");
      return [];
    }
  }



}