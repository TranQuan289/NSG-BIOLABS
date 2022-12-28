import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codebase/screens/new_booking_select_time/new_booking_select_time_repository.dart';
import 'package:domain/domain.dart';

part 'info_booking_event.dart';
part 'info_booking_state.dart';

class InfoBookingBloc extends Bloc<InfoBookingEvent, InfoBookingState> {
  NewBookingSelectTimeRepository newBookingSelectTimeRepository;
  InfoBookingBloc(this.newBookingSelectTimeRepository)
      : super(InfoBookingInitial(
          equipmentItem: null,
          meetingRoomItem: null,
        )) {
    on<FetchDataInfoBookingEvent>(_onFetchDataInfoBookingEvent);
    on<ToggleLikeInfoBookingEvent>(_onToggleLikeInfoBookingEvent);
  }

  FutureOr<void> _onFetchDataInfoBookingEvent(
      FetchDataInfoBookingEvent event, Emitter<InfoBookingState> emit) {
    try {
      
       emit(
        InfoBookingSuccess(
          equipmentItem: event.equipmentItem ?? state.equipmentItem,
          meetingRoomItem: event.meetingRoomItem ?? state.meetingRoomItem,
        ),
      );
    } catch (e) {
      emit(
        InfoBookingError(
          errorMessage: e.toString(),
          equipmentItem: state.equipmentItem,
          meetingRoomItem: state.meetingRoomItem,
        ),
      );
    }
  }

  Future<FutureOr<void>> _onToggleLikeInfoBookingEvent(
      ToggleLikeInfoBookingEvent event, Emitter<InfoBookingState> emit) async {
    try {
      if (state.equipmentItem != null) {
        var toggleLikeEquipmentResult = await newBookingSelectTimeRepository
            .toggleLikeInfoEquipmentItem(id: event.equipmentItem?.id ?? 0);
        state.equipmentItem!.isLiked = toggleLikeEquipmentResult.object.isLiked;
        emit(
          InfoBookingLikeSuccess(
            equipmentItem: state.equipmentItem,
            meetingRoomItem: state.meetingRoomItem,
          ),
        );
      } else {
        var toggleLikeMeetingRoomResult = await newBookingSelectTimeRepository
            .toggleLikeInfoMeetingRoomsItem(id: event.meetingRoomItem?.id ?? 0);
        state.meetingRoomItem!.isLiked = toggleLikeMeetingRoomResult.object.isLiked;
        emit(
          InfoBookingLikeSuccess(
            equipmentItem: state.equipmentItem,
            meetingRoomItem: state.meetingRoomItem,
          ),
        );
      }
    } catch (e) {
      emit(
        InfoBookingError(
          errorMessage: e.toString(),
          equipmentItem: state.equipmentItem,
          meetingRoomItem: state.meetingRoomItem,
        ),
      );
    }
  }
}
