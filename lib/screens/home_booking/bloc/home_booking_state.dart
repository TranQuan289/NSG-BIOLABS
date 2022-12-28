part of 'home_booking_bloc.dart';

abstract class HomeBookingState {}

class HomeBookingInitial extends HomeBookingState {}

class HomeBookingSucess extends HomeBookingState {
  final List<UpcomingBooking> listUpcomingBooking;
  final List<OngoingBooking> listOngoingBooking;
  HomeBookingSucess({
    required this.listOngoingBooking,
    required this.listUpcomingBooking,
  });
}

class HomeBookingError extends HomeBookingState {
  final String errorMessage;
  HomeBookingError({
    required this.errorMessage,
  });
}
