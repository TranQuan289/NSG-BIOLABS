import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/models.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc()
      : super(GlobalInitial(
          listEquipment: [],
          listMeetingRoom: [],
          listNewEquipment: [],
          listNewMeetingRoom: [],
          listOngoingBooking: [],
          listUpcomingBooking: [],
        )) {
    on<UpdateList>(_onUpdateList);
    on<GlobalToggleLikeEquipment>(_onGlobalToggleLikeEquipment);
    on<GlobalToggleLikeMeetingRoom>(_onGlobalToggleLikeMeetingRoom);
    on<GlobalUpdateBooking>(_onGlobalUpdateUpcomingBooking);
    on<GlobalDeleteUpcomingBooking>(_onGlobalDeleteUpcomingBooking);
  }

  FutureOr<void> _onUpdateList(UpdateList event, Emitter<GlobalState> emit) {
    emit(GlobalInitial(
      listEquipment: event.listEquipment ?? state.listEquipment,
      listMeetingRoom: event.listMeetingRoom ?? state.listMeetingRoom,
      listNewEquipment: event.listNewEquipment ?? state.listNewEquipment,
      listNewMeetingRoom: event.listNewMeetingRoom ?? state.listNewMeetingRoom,
      listOngoingBooking: event.listOngoingBooking ?? state.listOngoingBooking,
      listUpcomingBooking: event.listUpcomingBooking ?? state.listUpcomingBooking,
      ongoingBooking: event.ongoingBooking ?? state.ongoingBooking,
      upcomingBooking: event.upcomingBooking ?? state.upcomingBooking,
    ));
  }

  FutureOr<void> _onGlobalToggleLikeEquipment(
      GlobalToggleLikeEquipment event, Emitter<GlobalState> emit) {
    var newListEquipment = [...state.listEquipment];
    var index = state.listEquipment.indexWhere((element) => element.id == event.equipmentItem.id);
    if (index >= 0) {
      newListEquipment.removeAt(index);
    } else {
      newListEquipment.insert(0, event.equipmentItem);
    }
    emit(
      GlobalInitial(
        listEquipment: newListEquipment,
        listMeetingRoom: state.listMeetingRoom,
        listNewEquipment: state.listNewEquipment,
        listNewMeetingRoom: state.listNewMeetingRoom,
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
        ongoingBooking: state.ongoingBooking,
        upcomingBooking: state.upcomingBooking,
      ),
    );
  }

  FutureOr<void> _onGlobalToggleLikeMeetingRoom(
      GlobalToggleLikeMeetingRoom event, Emitter<GlobalState> emit) {
    var newListMeetingRoom = [...state.listMeetingRoom];
    var index =
        state.listMeetingRoom.indexWhere((element) => element.id == event.meetingRoomItem.id);
    if (index >= 0) {
      newListMeetingRoom.removeAt(index);
    } else {
      newListMeetingRoom.insert(0, event.meetingRoomItem);
    }
    emit(
      GlobalInitial(
        listEquipment: state.listEquipment,
        listMeetingRoom: newListMeetingRoom,
        listNewEquipment: state.listNewEquipment,
        listNewMeetingRoom: state.listNewMeetingRoom,
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
        ongoingBooking: state.ongoingBooking,
        upcomingBooking: state.upcomingBooking,
      ),
    );
  }

  FutureOr<void> _onGlobalDeleteUpcomingBooking(
      GlobalDeleteUpcomingBooking event, Emitter<GlobalState> emit) {
    var newListUpcomingBooking = [...state.listUpcomingBooking];
    var index =
        state.listUpcomingBooking.indexWhere((element) => element.id == event.upcomingBooking.id);
    if (index >= 0) {
      newListUpcomingBooking.removeAt(index);
    }
    emit(
      GlobalInitial(
        listEquipment: state.listEquipment,
        listMeetingRoom: state.listMeetingRoom,
        listNewEquipment: state.listNewEquipment,
        listNewMeetingRoom: state.listNewMeetingRoom,
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: newListUpcomingBooking,
        ongoingBooking: state.ongoingBooking,
        upcomingBooking: state.upcomingBooking,
      ),
    );
  }

  FutureOr<void> _onGlobalUpdateUpcomingBooking(
      GlobalUpdateBooking event, Emitter<GlobalState> emit) {
    var newListOngoingBooking = [...state.listOngoingBooking];
    var newListUpcomingBooking = [...state.listUpcomingBooking];

    if (newListOngoingBooking.isNotEmpty) {
      var indexOngoing =
          newListOngoingBooking.indexWhere((element) => element.id == event.ongoingBooking?.id);
      if (indexOngoing >= 0) {
        newListOngoingBooking[indexOngoing] = event.ongoingBooking!;
      }
      emit(
        GlobalInitial(
          listEquipment: state.listEquipment,
          listMeetingRoom: state.listMeetingRoom,
          listNewEquipment: state.listNewEquipment,
          listNewMeetingRoom: state.listNewMeetingRoom,
          listOngoingBooking: newListOngoingBooking,
          listUpcomingBooking: state.listUpcomingBooking,
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
        ),
      );
    } else {
      var indexUpcoming =
          newListUpcomingBooking.indexWhere((element) => element.id == event.upcomingBooking?.id);
      if (indexUpcoming >= 0) {
        newListUpcomingBooking[indexUpcoming] = event.upcomingBooking!;
      }
      emit(
        GlobalInitial(
          listEquipment: state.listEquipment,
          listMeetingRoom: state.listMeetingRoom,
          listNewEquipment: state.listNewEquipment,
          listNewMeetingRoom: state.listNewMeetingRoom,
          listOngoingBooking: state.listOngoingBooking,
          listUpcomingBooking: newListUpcomingBooking,
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
        ),
      );
    }
  }
}
