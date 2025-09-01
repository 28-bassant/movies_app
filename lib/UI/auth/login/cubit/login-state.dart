import 'package:equatable/equatable.dart';

import '../../../../model/register_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final UserData user;
  final String message;
  const LoginSuccess(this.user, this.message);

  @override
  List<Object?> get props => [user, message];
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
class GoogleLoginSuccess extends LoginState {
  final String name;
  const GoogleLoginSuccess(this.name);

  @override
  List<Object?> get props => [name];
}

class GoogleLoginCancelled extends LoginState {}

class GoogleLoginFailure extends LoginState {
  final String error;
  const GoogleLoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
