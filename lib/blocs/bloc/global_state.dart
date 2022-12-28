part of 'global_bloc.dart';

abstract class GlobalState {
  final List<EquipmentItem> listEquipment;
  final List<MeetingRoomItem> listMeetingRoom;
  final List<EquipmentItem> listNewEquipment;
  final List<MeetingRoomItem> listNewMeetingRoom;
  final List<OngoingBooking> listOngoingBooking;
  final List<UpcomingBooking> listUpcomingBooking;
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  GlobalState({
    required this.listEquipment,
    required this.listMeetingRoom,
    required this.listNewEquipment,
    required this.listNewMeetingRoom,
    required this.listOngoingBooking,
    required this.listUpcomingBooking,
    required this.ongoingBooking,
    required this.upcomingBooking,
  });
}

class GlobalInitial extends GlobalState {
  GlobalInitial({
    required super.listEquipment,
    required super.listMeetingRoom,
    required super.listNewEquipment,
    required super.listNewMeetingRoom,
    required super.listOngoingBooking,
    required super.listUpcomingBooking,
    super.ongoingBooking,
    super.upcomingBooking,
  });
}
