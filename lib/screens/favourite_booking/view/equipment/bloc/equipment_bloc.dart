import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  FavouriteBookingRepository favouriteBookingRepository;
  int pageEquipment = 1;
  RefreshController equipmentRefreshController = RefreshController();
  EquipmentBloc(this.favouriteBookingRepository) : super(EquipmentInitial()) {
    on<FetchDataEquipmentEvent>(_onFetchDataEquipmentEvent);
    on<ToggleLikeEquipmentEvent>(_onToggleLikeEquipmentEvent);
    on<RefreshEquipmentEvent>(_onRefreshEquipmentEvent);
    on<LoadMoreEquipmentEvent>(_onLoadMoreEquipmentEvent);
  }

  FutureOr<void> _onFetchDataEquipmentEvent(
      FetchDataEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      var equipmentResult = await favouriteBookingRepository.getFavouriteEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        dataMode: 'equipment_items',
      );
      emit(
        EquipmentSuccess(
          listEquipment: equipmentResult.list,
        ),
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onToggleLikeEquipmentEvent(
      ToggleLikeEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      await favouriteBookingRepository.toggleLikeFavouriteEquipmentItem(
          id: event.favouriteEquipment.id ?? 0);
      emit(
        EquipmentLikeSuccess(
          favouriteEquipment: event.favouriteEquipment,
        ),
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onRefreshEquipmentEvent(
      RefreshEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () => equipmentRefreshController.refreshCompleted(),
      ).then(
        (value) async {
          pageEquipment = 1;
          var equipmentResult = await favouriteBookingRepository.getFavouriteEquipmentItems(
              page: pageEquipment, perPage: 10, dataMode: 'equipment_items');
          emit(
            EquipmentSuccess(
              listEquipment: equipmentResult.list,
            ),
          );
        },
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreEquipmentEvent(
      LoadMoreEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      var curentListEquipment = (state as EquipmentSuccess).listEquipment;
      pageEquipment += 1;
      var equipmentResult = await favouriteBookingRepository.getFavouriteEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        dataMode: 'equipment_items',
      );
      await Future.delayed(const Duration(seconds: 1));
      if (equipmentResult.list.isEmpty) {
        equipmentRefreshController.loadFailed();
      } else {
        var newListEquipment = List<EquipmentItem>.from(curentListEquipment)
          ..addAll(equipmentResult.list);
        equipmentRefreshController.loadComplete();
        emit(
          EquipmentSuccess(
            listEquipment: newListEquipment,
          ),
        );
      }
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }
}
