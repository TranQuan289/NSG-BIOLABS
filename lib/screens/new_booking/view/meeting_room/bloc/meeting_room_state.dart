part of 'meeting_room_bloc.dart';

abstract class MeetingRoomState {
  final List<MeetingRoomItem> listMeetingRoom;
  MeetingRoomState({
    required this.listMeetingRoom,
  });
}

class MeetingRoomInitial extends MeetingRoomState {
  MeetingRoomInitial({required super.listMeetingRoom});
}

class MeetingRoomSuccess extends MeetingRoomState {
  MeetingRoomSuccess({
    required super.listMeetingRoom,
  });
}

class MeetingRoomLikeSuccess extends MeetingRoomState {
  final MeetingRoomItem meetingRoomItem;
  MeetingRoomLikeSuccess({required super.listMeetingRoom, required this.meetingRoomItem});
}

class MeetingRoomError extends MeetingRoomState {
  final String errorMessage;
  MeetingRoomError({required super.listMeetingRoom, required this.errorMessage});
}
