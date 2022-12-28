import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'details_meeting_room_booking_event.dart';
part 'details_meeting_room_booking_state.dart';

class DetailsMeetingRoomBookingBloc
    extends Bloc<DetailsMeetingRoomBookingEvent, DetailsMeetingRoomBookingState> {
  DetailsMeetingRoomBookingBloc() : super(DetailsMeetingRoomBookingInitial()) {
    on<FetchDataDetailsMeetingRoomEvent>(_onFetchDataDetailsMeetingRoomEvent);
  }

  FutureOr<void> _onFetchDataDetailsMeetingRoomEvent(
      FetchDataDetailsMeetingRoomEvent event, Emitter<DetailsMeetingRoomBookingState> emit) {
    try {
      emit(DetailsMeetingRoomBookingSuccess(
        ongoingBookingMeetingRoom: event.ongoingBookingMeetingRoom,
        upcomingBookingMeetingRoom: event.upcomingBookingMeetingRoom,
      ));
    } catch (e) {
      emit(DetailsMeetingRoomBookingError(errorMessage: e.toString()));
    }
  }
}
