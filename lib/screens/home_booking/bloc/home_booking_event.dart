part of 'home_booking_bloc.dart';

abstract class HomeBookingEvent {}

class FetchDataHomeBookingEvent extends HomeBookingEvent {}

class RefreshUpcomingBookingEvent extends HomeBookingEvent {}

class LoadMoreUpcomingBookingEvent extends HomeBookingEvent {}
