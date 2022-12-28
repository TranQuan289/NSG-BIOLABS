part of 'edit_booking_bloc.dart';

abstract class EditBookingEvent {}

class FetchDataEditBookingEvent extends EditBookingEvent {
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  FetchDataEditBookingEvent({
    this.ongoingBooking,
    this.upcomingBooking,
  });
}

class DeleteBookingEvent extends EditBookingEvent {
  final int id;
  DeleteBookingEvent({
    required this.id,
  });
}

class UpdateBookingEvent extends EditBookingEvent {
  final int id;
  final DateTime fromDate;
  final DateTime toDate;
  final double fromTime;
  final double toTime;
  UpdateBookingEvent({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
  });
}
