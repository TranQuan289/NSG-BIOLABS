import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'meeting_room_event.dart';
part 'meeting_room_state.dart';

class MeetingRoomBloc extends Bloc<MeetingRoomEvent, MeetingRoomState> {
  NewBookingRepository newBookingRepository;
  RefreshController meetingRoomRefreshController = RefreshController();
  TextEditingController meetingRoomTextEditingController = TextEditingController();
  int pageMeetingRoom = 1;
  MeetingRoomBloc(this.newBookingRepository) : super(MeetingRoomInitial(listMeetingRoom: [])) {
    on<FetchDataMeetingRoomEvent>(_onFetchDataMeetingRoomEvent);
    on<SearchMeetingRoomEvent>(_onSearchMeetingRoomEvent);
    on<RefreshMeetingRoomEvent>(_onRefreshMeetingRoomEvent);
    on<LoadMoreMeetingRoomEvent>(_onLoadMoreMeetingRoomEvent);
    on<ToggleLikeMeetingRoomEvent>(_onToggleLikeMeetingRoomEvent);
  }

  FutureOr<void> _onFetchDataMeetingRoomEvent(
      FetchDataMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      var meetingRoomResult = await newBookingRepository.getNewBookingMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        keywords: meetingRoomTextEditingController.text,
      );
      emit(
        MeetingRoomSuccess(
          listMeetingRoom: meetingRoomResult.list,
        ),
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onSearchMeetingRoomEvent(
      SearchMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      pageMeetingRoom = 1;
      var meetingRoomResultSearch = await newBookingRepository.getNewBookingMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        keywords: meetingRoomTextEditingController.text,
      );
      emit(
        MeetingRoomSuccess(
          listMeetingRoom: meetingRoomResultSearch.list,
        ),
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
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
          var meetingRoomResult = await newBookingRepository.getNewBookingMeetingRooms(
            page: pageMeetingRoom,
            perPage: 5,
            keywords: meetingRoomTextEditingController.text,
          );
          emit(
            MeetingRoomSuccess(
              listMeetingRoom: meetingRoomResult.list,
            ),
          );
        },
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onLoadMoreMeetingRoomEvent(
      LoadMoreMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      var currentMeetingRoom = (state as MeetingRoomSuccess).listMeetingRoom;
      pageMeetingRoom += 1;
      var meetingRoomResult = await newBookingRepository.getNewBookingMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        keywords: meetingRoomTextEditingController.text,
      );
      await Future.delayed(const Duration(seconds: 1));
      if (meetingRoomResult.list.isEmpty) {
        meetingRoomRefreshController.loadFailed();
      } else {
        var newlistMeetingRoom = List<MeetingRoomItem>.from(currentMeetingRoom)
          ..addAll(meetingRoomResult.list);
        meetingRoomRefreshController.loadComplete();
        emit(
          MeetingRoomSuccess(
            listMeetingRoom: newlistMeetingRoom,
          ),
        );
      }
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onToggleLikeMeetingRoomEvent(
      ToggleLikeMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      var newListMeetingRoom = [...state.listMeetingRoom];
      var index =
          newListMeetingRoom.indexWhere((element) => element.id == event.meetingRoomItem.id);
      if (index >= 0) {
        var toggleLikeMeetingRoomResult = await newBookingRepository
            .toggleLikeNewBookingMeetingRoomsItem(id: event.meetingRoomItem.id ?? 0);
        newListMeetingRoom[index].isLiked = toggleLikeMeetingRoomResult.object.isLiked;
      }

      emit(
        MeetingRoomLikeSuccess(
          listMeetingRoom: newListMeetingRoom,
          meetingRoomItem: event.meetingRoomItem,
        ),
      );
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }
}
