import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codebase/screens/new_booking_review/new_booking_review_repository.dart';
import 'package:domain/domain.dart';

part 'new_booking_review_event.dart';
part 'new_booking_review_state.dart';

class NewBookingReviewBloc extends Bloc<NewBookingReviewEvent, NewBookingReviewState> {
  NewBookingReviewRepository newBookingReviewRepository;
  NewBookingReviewBloc(
    this.newBookingReviewRepository,
  ) : super(NewBookingReviewInitial()) {
    on<FetchDataBookingReviewEvent>(_onFetchDataBookingReviewEvent);

    on<AddBookingEvent>(_onAddBookingEvent);
  }

  FutureOr<void> _onFetchDataBookingReviewEvent(
      FetchDataBookingReviewEvent event, Emitter<NewBookingReviewState> emit) {
    emit(
      NewBookingReviewInitial(
        equipmentItem: event.equipmentItem,
        meetingRoomItem: event.meetingRoomItem,
      ),
    );
  }

  FutureOr<void> _onAddBookingEvent(
      AddBookingEvent event, Emitter<NewBookingReviewState> emit) async {
    try {
      await newBookingReviewRepository.addNewBooking(
        orderableType: event.orderableType,
        orderableId: event.orderableId,
        startDate: event.fromDate,
        endDate: event.toDate,
        startTime: event.fromTime,
        endTime: event.toTime,
      );
      emit(
        NewBookingReviewSuccess(
          equipmentItem: state.equipmentItem,
          meetingRoomItem: state.meetingRoomItem,
        ),
      );
    } catch (e) {
      emit(
        NewBookingReviewError(
          equipmentItem: state.equipmentItem,
          meetingRoomItem: state.meetingRoomItem,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
