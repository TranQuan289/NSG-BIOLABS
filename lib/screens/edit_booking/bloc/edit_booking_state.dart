part of 'edit_booking_bloc.dart';

abstract class EditBookingState {
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  EditBookingState({
    this.ongoingBooking,
    this.upcomingBooking,
  });
}

class EditBookingInitial extends EditBookingState {
  EditBookingInitial({
    super.ongoingBooking,
    super.upcomingBooking,
  });
}

class EditBookingSuccess extends EditBookingState {
  EditBookingSuccess({
    super.ongoingBooking,
    super.upcomingBooking,
  });
}

class EditBookingDeleteSuccess extends EditBookingState {
  EditBookingDeleteSuccess({
    super.ongoingBooking,
    super.upcomingBooking,
  });
}

class EditBookingUpdateSuccess extends EditBookingState {
  EditBookingUpdateSuccess({
    super.ongoingBooking,
    super.upcomingBooking,
  });
}

class EditBookingDeleteError extends EditBookingState {
  final String errorMessage;
  EditBookingDeleteError({
    required this.errorMessage,
    super.ongoingBooking,
    super.upcomingBooking,
  });
}


class EditBookingUpdateError extends EditBookingState {
  final String errorMessage;
  EditBookingUpdateError({
    required this.errorMessage,
    super.ongoingBooking,
    super.upcomingBooking,
  });
}
