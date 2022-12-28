part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class ChangePassword extends ChangePasswordEvent {
  final String? currentPassword;
  final String? newPassword;
  final String? newPasswordConfirmation;
  ChangePassword(
      {required this.currentPassword,
      required this.newPassword,
      required this.newPasswordConfirmation});
}
