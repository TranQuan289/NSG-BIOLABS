part of 'global_bloc.dart';

abstract class GlobalEvent {}

class UpdateList extends GlobalEvent {
  final List<EquipmentItem>? listEquipment;
  final List<MeetingRoomItem>? listMeetingRoom;
  final List<EquipmentItem>? listNewEquipment;
  final List<MeetingRoomItem>? listNewMeetingRoom;
  final List<OngoingBooking>? listOngoingBooking;
  final List<UpcomingBooking>? listUpcomingBooking;
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  UpdateList({
    this.listEquipment,
    this.listMeetingRoom,
    this.listNewEquipment,
    this.listNewMeetingRoom,
    this.listOngoingBooking,
    this.listUpcomingBooking,
    this.ongoingBooking,
    this.upcomingBooking,
  });
}

class GlobalToggleLikeEquipment extends GlobalEvent {
  final EquipmentItem equipmentItem;
  GlobalToggleLikeEquipment({
    required this.equipmentItem,
  });
}

class GlobalToggleLikeMeetingRoom extends GlobalEvent {
  final MeetingRoomItem meetingRoomItem;
  GlobalToggleLikeMeetingRoom({
    required this.meetingRoomItem,
  });
}

class GlobalUpdateBooking extends GlobalEvent {
  final UpcomingBooking? upcomingBooking;
  final OngoingBooking? ongoingBooking;
  GlobalUpdateBooking({
    this.upcomingBooking,
    this.ongoingBooking,
  });
}

class GlobalDeleteUpcomingBooking extends GlobalEvent {
  final UpcomingBooking upcomingBooking;
  GlobalDeleteUpcomingBooking({
    required this.upcomingBooking,
  });
}
