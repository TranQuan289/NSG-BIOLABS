import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import '../edit_booking_repository.dart';

part 'edit_booking_event.dart';
part 'edit_booking_state.dart';

class EditBookingBloc extends Bloc<EditBookingEvent, EditBookingState> {
  EditBookingRepository editBookingRepository;
  EditBookingBloc(
    this.editBookingRepository,
  ) : super(EditBookingInitial()) {
    on<FetchDataEditBookingEvent>(_onFetchDataEditBookingEvent);
    on<DeleteBookingEvent>(_onDeleteBookingEvent);
    on<UpdateBookingEvent>(_onUpdateBookingEvent);
  }

  FutureOr<void> _onFetchDataEditBookingEvent(
      FetchDataEditBookingEvent event, Emitter<EditBookingState> emit) {
    emit(
      EditBookingInitial(
        ongoingBooking: event.ongoingBooking,
        upcomingBooking: event.upcomingBooking,
      ),
    );
  }

  FutureOr<void> _onDeleteBookingEvent(
      DeleteBookingEvent event, Emitter<EditBookingState> emit) async {

    try {
      await editBookingRepository.deleteBooking(id: event.id);
      emit(
        EditBookingDeleteSuccess(
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
        ),
      );
    } catch (e) {
      emit(
        EditBookingDeleteError(
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onUpdateBookingEvent(
      UpdateBookingEvent event, Emitter<EditBookingState> emit) async {
    try {
      await editBookingRepository.updateBooking(
        id: event.id,
        startDate: event.fromDate,
        startTime: event.fromTime,
        endDate: event.toDate,
        endTime: event.toTime,
      );
      emit(
        EditBookingUpdateSuccess(
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
        ),
      );
    } catch (e) {
      emit(
        EditBookingUpdateError(
          ongoingBooking: state.ongoingBooking,
          upcomingBooking: state.upcomingBooking,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
