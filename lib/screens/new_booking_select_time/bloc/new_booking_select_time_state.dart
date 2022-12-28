part of 'new_booking_select_time_bloc.dart';

abstract class NewBookingSelectTimeState {
  final List<DateTime> listTime;
  DateTime dateTime;
  NewBookingSelectTimeState({
    required this.listTime,
    required this.dateTime,
  });
}

class NewBookingSelectTimeInitial extends NewBookingSelectTimeState {
  NewBookingSelectTimeInitial({required super.dateTime,required super.listTime});
}
