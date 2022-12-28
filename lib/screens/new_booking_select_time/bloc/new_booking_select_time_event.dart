part of 'new_booking_select_time_bloc.dart';

abstract class NewBookingSelectTimeEvent {}

class FetchDateEvent extends NewBookingSelectTimeEvent {
  final DateTime dateTime;
  FetchDateEvent({
    required this.dateTime,
  });
}

class NextDateEvent extends NewBookingSelectTimeEvent {}

class PreviousDateEvent extends NewBookingSelectTimeEvent {}

class ToggleDetailsEvent extends NewBookingSelectTimeEvent{}