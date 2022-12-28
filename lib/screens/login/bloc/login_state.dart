part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {
  LoginInitial();
}

class LoginSuccess extends LoginState {
  LoginSuccess();
}

class LoginError extends LoginState {
  final String? messageError;
  LoginError(this.messageError);
}
