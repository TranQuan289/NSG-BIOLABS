import 'package:bloc/bloc.dart';
import 'package:codebase/utilities/validation/validate.dart';
import 'package:flutter/material.dart';
import '../../../utilities/shared_preferences/shared_preferences.dart';
import '../login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  LoginRepository loginRepository;

  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();

  _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    if (validateEmail(event.email).isNotEmpty) {
      emit(LoginError(validateEmail(event.email)));
    } else if (validatePassword(event.password).isNotEmpty) {
      emit(LoginError(validatePassword(event.password)));
    } else {
      try {
        final response =
            await loginRepository.loginWithEmail(email: event.email, password: event.password);
        await setToken(response.object.token?? '');
        await settokenExpired(response.object.tokenExpiredAt?? '');
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    }
  }
}
