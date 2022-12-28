part of 'meeting_room_bloc.dart';

abstract class MeetingRoomEvent {}

class FetchDataMeetingRoomEvent extends MeetingRoomEvent {}

class SearchMeetingRoomEvent extends MeetingRoomEvent {}

class RefreshMeetingRoomEvent extends MeetingRoomEvent {}

class LoadMoreMeetingRoomEvent extends MeetingRoomEvent {}

class ToggleLikeMeetingRoomEvent extends MeetingRoomEvent {
  final MeetingRoomItem meetingRoomItem;
  ToggleLikeMeetingRoomEvent({
    required this.meetingRoomItem,
  });
}
