import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../api/api-manager.dart';
import 'login-state.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel() : super(LoginInitial());

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await ApiManager.login(email, password);

      if (response.message == "Success Login") {
        final token = response.token;
        if (token == null) {
          emit(LoginFailure("Token not found"));
          return;
        }
        final user = await ApiManager.fetchProfile(token);
        emit(LoginSuccess(user, "Login Successful"));
      } else {
        emit(LoginFailure(response.message));
      }
    } on SocketException {
      emit(LoginFailure("No Internet Connection"));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    try {
      final account = await googleSignIn.signIn();
      if (account != null) {
        emit(GoogleLoginSuccess(account.displayName ?? "User"));
      } else {
        emit(GoogleLoginCancelled());
      }
    } catch (e) {
      emit(GoogleLoginFailure(e.toString()));
    }
  }
}