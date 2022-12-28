import 'dart:async';

import 'package:bloc/bloc.dart';

part 'new_booking_select_time_event.dart';
part 'new_booking_select_time_state.dart';

class NewBookingSelectTimeBloc extends Bloc<NewBookingSelectTimeEvent, NewBookingSelectTimeState> {
  bool isOpen = false;
  NewBookingSelectTimeBloc()
      : super(
          NewBookingSelectTimeInitial(
            dateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              12,
              0,
            ),
            listTime: [],
          ),
        ) {
    on<FetchDateEvent>(_onFetchDateEvent);
    on<NextDateEvent>(_onNextDateEvent);
    on<PreviousDateEvent>(_onPreviousDateEvent);
    on<ToggleDetailsEvent>(_onToggleDetailsEvent);
  }
  FutureOr<void> _onFetchDateEvent(FetchDateEvent event, Emitter<NewBookingSelectTimeState> emit) {
    List<DateTime> listTime = List<DateTime>.generate(
      24,
      (index) => state.dateTime.add(
        Duration(
          hours: index + 12,
        ),
      ),
    );
    emit(NewBookingSelectTimeInitial(dateTime: event.dateTime, listTime: listTime));
  }

  FutureOr<void> _onNextDateEvent(NextDateEvent event, Emitter<NewBookingSelectTimeState> emit) {
    var newDate = state.dateTime;
    newDate = DateTime(state.dateTime.year, state.dateTime.month, state.dateTime.day + 1);
    emit(NewBookingSelectTimeInitial(dateTime: newDate, listTime: state.listTime));
  }

  FutureOr<void> _onPreviousDateEvent(
      PreviousDateEvent event, Emitter<NewBookingSelectTimeState> emit) {
    var newDate = state.dateTime;
    newDate = DateTime(state.dateTime.year, state.dateTime.month, state.dateTime.day - 1);
    emit(NewBookingSelectTimeInitial(dateTime: newDate, listTime: state.listTime));
  }

  FutureOr<void> _onToggleDetailsEvent(
      ToggleDetailsEvent event, Emitter<NewBookingSelectTimeState> emit) {
    isOpen = !isOpen;
    emit(NewBookingSelectTimeInitial(dateTime: state.dateTime, listTime: state.listTime));
  }
}
