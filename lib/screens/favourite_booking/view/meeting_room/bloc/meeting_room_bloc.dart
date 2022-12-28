import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'meeting_room_event.dart';
part 'meeting_room_state.dart';

class MeetingRoomBloc extends Bloc<MeetingRoomEvent, MeetingRoomState> {
  FavouriteBookingRepository favouriteBookingRepository;
  RefreshController meetingRoomRefreshController = RefreshController();
  int pageMeetingRoom = 1;
  MeetingRoomBloc(this.favouriteBookingRepository) : super(MeetingRoomInitial()) {
    on<FetchDataMeetingRoomEvent>(_onFetchDataMeetingRoomEvent);
    on<ToggleLikeMeetingRoomEvent>(_onToggleLikeMeetingRoomEvent);
    on<RefreshMeetingRoomEvent>(_onRefreshMeetingRoomEvent);
    on<LoadMoreMeetingRoomEvent>(_onLoadMoreMeetingRoomEvent);
  }

  FutureOr<void> _onFetchDataMeetingRoomEvent(
      FetchDataMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      var meetingRoomResult = await favouriteBookingRepository.getFavouriteMeetingRooms(
        page: pageMeetingRoom,
        perPage: 10,
        dataMode: 'meeting_rooms',
      );
      emit(
        MeetingRoomSuccess(
          listMeetingRoom: meetingRoomResult.list,
        ),
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onToggleLikeMeetingRoomEvent(
      ToggleLikeMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      await favouriteBookingRepository.toggleLikeFavouriteMeetingRoomsItem(
          id: event.favouriteMeetingRoom.id ?? 0);
      emit(
        MeetingRoomLikeSuccess(
          favouriteMeetingRoom: event.favouriteMeetingRoom,
        ),
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onRefreshMeetingRoomEvent(
      RefreshMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () => meetingRoomRefreshController.refreshCompleted(),
      ).then(
        (value) async {
          pageMeetingRoom = 1;
          var meetingRoomResult = await favouriteBookingRepository.getFavouriteMeetingRooms(
            page: pageMeetingRoom,
            perPage: 10,
            dataMode: 'meeting_rooms',
          );
          emit(
            MeetingRoomSuccess(
              listMeetingRoom: meetingRoomResult.list,
            ),
          );
        },
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreMeetingRoomEvent(
      LoadMoreMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      var currentMeetingRoom = (state as MeetingRoomSuccess).listMeetingRoom;
      pageMeetingRoom += 1;
      var meetingRoomResult = await favouriteBookingRepository.getFavouriteMeetingRooms(
        page: pageMeetingRoom,
        perPage: 10,
        dataMode: 'meeting_rooms',
      );
      await Future.delayed(const Duration(seconds: 1));
      if (meetingRoomResult.list.isEmpty) {
        meetingRoomRefreshController.loadFailed();
      } else {
        var newListMeetingRoom = List<MeetingRoomItem>.from(currentMeetingRoom)
          ..addAll(meetingRoomResult.list);
        meetingRoomRefreshController.loadComplete();
        emit(
          MeetingRoomSuccess(
            listMeetingRoom: newListMeetingRoom,
          ),
        );
      }
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }
}
