part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordNotify extends ChangePasswordState {
  final String? title;
  final String? body;
  ChangePasswordNotify(this.title, this.body);
}
