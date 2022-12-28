part of 'info_booking_bloc.dart';

abstract class InfoBookingState {
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  InfoBookingState({
    required this.equipmentItem,
    required this.meetingRoomItem,
  });
}

class InfoBookingInitial extends InfoBookingState {
  InfoBookingInitial({
    required super.equipmentItem,
    required super.meetingRoomItem,
  });
}

class InfoBookingSuccess extends InfoBookingState {
  InfoBookingSuccess({
    required super.equipmentItem,
    required super.meetingRoomItem,
  });
}

class InfoBookingLikeSuccess extends InfoBookingState {
  InfoBookingLikeSuccess({
    required super.equipmentItem,
    required super.meetingRoomItem,
  });
}

class InfoBookingError extends InfoBookingState {
  final String errorMessage;
  InfoBookingError({
    required super.equipmentItem,
    required super.meetingRoomItem,
    required this.errorMessage,
  });
}
