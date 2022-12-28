import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/models.dart';

part 'details_equipment_booking_event.dart';
part 'details_equipment_booking_state.dart';

class DetailsEquipmentBookingBloc
    extends Bloc<DetailsEquipmentBookingEvent, DetailsEquipmentBookingState> {
  DetailsEquipmentBookingBloc() : super(DetailsEquipmentBookingInitial()) {
    on<FetchDataDetailsEquipmentEvent>(_onFetchDataDetailsEquipmentEvent);
  }

  FutureOr<void> _onFetchDataDetailsEquipmentEvent(
      FetchDataDetailsEquipmentEvent event, Emitter<DetailsEquipmentBookingState> emit) {
    try {
      emit(DetailsEquipmentBookingSuccess(
        ongoingBookingEquipment: event.ongoingBookingEquipment,
        upcomingBookingEquipment: event.upcomingBookingEquipment,
      ));
    } catch (e) {
      emit(DetailsEquipmentBookingError(errorMessage: e.toString()));
    }
  }
}
