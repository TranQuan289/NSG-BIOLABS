part of 'details_meeting_room_booking_bloc.dart';

abstract class DetailsMeetingRoomBookingState {}

class DetailsMeetingRoomBookingInitial extends DetailsMeetingRoomBookingState {}

class DetailsMeetingRoomBookingSuccess extends DetailsMeetingRoomBookingState {
  OngoingBooking? ongoingBookingMeetingRoom;
  UpcomingBooking? upcomingBookingMeetingRoom;
  DetailsMeetingRoomBookingSuccess({
    required this.ongoingBookingMeetingRoom,
    required this.upcomingBookingMeetingRoom,
  });
}

class DetailsMeetingRoomBookingError extends DetailsMeetingRoomBookingState {
  final String errorMessage;
  DetailsMeetingRoomBookingError({
    required this.errorMessage,
  });
}
