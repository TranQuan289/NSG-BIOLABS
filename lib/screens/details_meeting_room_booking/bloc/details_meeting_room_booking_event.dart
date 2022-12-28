part of 'details_meeting_room_booking_bloc.dart';

abstract class DetailsMeetingRoomBookingEvent {}

class FetchDataDetailsMeetingRoomEvent extends DetailsMeetingRoomBookingEvent {
  OngoingBooking? ongoingBookingMeetingRoom;
  UpcomingBooking? upcomingBookingMeetingRoom;
  FetchDataDetailsMeetingRoomEvent({
    required this.ongoingBookingMeetingRoom,
    required this.upcomingBookingMeetingRoom,
  });
}
