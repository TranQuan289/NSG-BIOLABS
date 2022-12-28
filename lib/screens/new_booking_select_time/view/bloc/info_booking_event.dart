part of 'info_booking_bloc.dart';

abstract class InfoBookingEvent {}

class FetchDataInfoBookingEvent extends InfoBookingEvent {
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  FetchDataInfoBookingEvent({
    this.equipmentItem,
    this.meetingRoomItem,
  });
}

class ToggleLikeInfoBookingEvent extends InfoBookingEvent {
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  ToggleLikeInfoBookingEvent({
    this.equipmentItem,
    this.meetingRoomItem,
  });
}
