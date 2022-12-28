import 'package:bloc/bloc.dart';

part 'new_booking_event.dart';
part 'new_booking_state.dart';

class NewBookingBloc extends Bloc<NewBookingEvent, NewBookingState> {
  NewBookingBloc() : super(NewBookingInitial()) {
    on((event, emit) => null);
  }

}
