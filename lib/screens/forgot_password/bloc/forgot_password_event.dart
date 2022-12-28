part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordRequest extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordRequest({required this.email});
}

