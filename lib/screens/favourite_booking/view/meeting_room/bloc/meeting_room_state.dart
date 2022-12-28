part of 'meeting_room_bloc.dart';

abstract class MeetingRoomState {}

class MeetingRoomInitial extends MeetingRoomState {}

class MeetingRoomSuccess extends MeetingRoomState {
  final List<MeetingRoomItem> listMeetingRoom;
  MeetingRoomSuccess({
    required this.listMeetingRoom,
  });
}

class MeetingRoomLikeSuccess extends MeetingRoomState {
  final MeetingRoomItem favouriteMeetingRoom;
  MeetingRoomLikeSuccess({
    required this.favouriteMeetingRoom,
  });
}

class MeetingRoomError extends MeetingRoomState {
  final String errorMessage;
  MeetingRoomError({
    required this.errorMessage,
  });
}
