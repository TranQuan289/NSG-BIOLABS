import 'package:bloc/bloc.dart';

part 'forgot_password_submit_event.dart';
part 'forgot_password_submit_state.dart';

class ForgotPasswordSubmitBloc extends Bloc<ForgotPasswordSubmitEvent, ForgotPasswordSubmitState> {
  ForgotPasswordSubmitBloc() : super(ForgotPasswordSubmitInitial()) {
    on<ForgotPasswordSubmitEvent>((event, emit) {
    });
  }
}
