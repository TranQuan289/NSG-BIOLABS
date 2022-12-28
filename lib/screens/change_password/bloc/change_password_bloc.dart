import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codebase/screens/change_password/change_password_repository.dart';
import 'package:codebase/utilities/validation/validate.dart';
import 'package:flutter/material.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(this.changePasswordRepository) : super(ChangePasswordInitial()) {
    on<ChangePassword>(_onChangePassword);
  }
  ChangePasswordRepository changePasswordRepository;
  TextEditingController currentPasswordCotroller = TextEditingController();
  TextEditingController newPasswordCotroller = TextEditingController();
  TextEditingController confirmPasswordCotroller = TextEditingController();

  FutureOr<void> _onChangePassword(ChangePassword event, Emitter<ChangePasswordState> emit) async {
    if (validateUpdatePassword(
            currentPassword: event.currentPassword.toString(),
            newPassword: event.newPassword.toString(),
            newPasswordConfirmation: event.newPasswordConfirmation.toString())
        .isNotEmpty) {
      emit(ChangePasswordNotify(
          validateUpdatePassword(
              currentPassword: event.currentPassword.toString(),
              newPassword: event.newPassword.toString(),
              newPasswordConfirmation: event.newPasswordConfirmation.toString()),
          ''));
    } else {
      try {
        await changePasswordRepository.updatePassword(
            currentPassword: event.currentPassword,
            newPassword: event.newPassword,
            newPasswordConfirmation: event.newPasswordConfirmation);
        emit(ChangePasswordNotify('Password Updated', 'Your password has been updated.'));
      } catch (e) {
        emit(ChangePasswordNotify(e.toString(), ''));
      }
    }
  }
}
