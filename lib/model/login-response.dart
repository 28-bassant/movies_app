import 'package:movies_app/model/register_response.dart';

class LoginResponse {
  final String message;
  final String? token;
  final UserData? user;

  LoginResponse({required this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }


}