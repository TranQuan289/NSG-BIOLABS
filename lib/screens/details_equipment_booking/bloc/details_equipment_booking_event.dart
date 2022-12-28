part of 'details_equipment_booking_bloc.dart';

abstract class DetailsEquipmentBookingEvent {}

class FetchDataDetailsEquipmentEvent extends DetailsEquipmentBookingEvent {
  OngoingBooking? ongoingBookingEquipment;
  UpcomingBooking? upcomingBookingEquipment;
  FetchDataDetailsEquipmentEvent({
    required this.ongoingBookingEquipment,
    required this.upcomingBookingEquipment,
  });
}
