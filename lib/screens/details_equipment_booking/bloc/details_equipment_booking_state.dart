part of 'details_equipment_booking_bloc.dart';

abstract class DetailsEquipmentBookingState {}

class DetailsEquipmentBookingInitial extends DetailsEquipmentBookingState {}

class DetailsEquipmentBookingSuccess extends DetailsEquipmentBookingState {
  OngoingBooking? ongoingBookingEquipment;
  UpcomingBooking? upcomingBookingEquipment;
  DetailsEquipmentBookingSuccess({
    required this.ongoingBookingEquipment,
    required this.upcomingBookingEquipment,
  });
}

class DetailsEquipmentBookingError extends DetailsEquipmentBookingState {
  final String errorMessage;
  DetailsEquipmentBookingError({
    required this.errorMessage,
  });
}
