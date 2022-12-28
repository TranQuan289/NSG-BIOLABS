import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/equipment_items/new_equipment_items_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  NewBookingRepository newBookingRepository;
  RefreshController equipmentRefreshController = RefreshController();
  TextEditingController equipmentTextEditingController = TextEditingController();
  int pageEquipment = 1;
  EquipmentBloc(this.newBookingRepository) : super(EquipmentInitial(listEquipment: [])) {
    on<FetchDataEquipmentEvent>(_onFetchDataEquipmentEvent);
    on<SearchEquipmentEvent>(_onSearchEquipmentEvent);
    on<RefreshEquipmentEvent>(_onRefreshEquipmentEvent);
    on<LoadMoreEquipmentEvent>(_onLoadMoreEquipmentEvent);
    on<ToggleLikeEquipmentEvent>(_onToggleLikeEquipmentEvent);
  }

  FutureOr<void> _onFetchDataEquipmentEvent(
      FetchDataEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      var equipmentResult = await newBookingRepository.getNewBookingEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        keywords: equipmentTextEditingController.text,
      );
      emit(
        EquipmentSuccess(
          listEquipment: equipmentResult.list,
        ),
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onSearchEquipmentEvent(
      SearchEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      pageEquipment = 1;
      var equipmentResultSearch = await newBookingRepository.getNewBookingEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        keywords: equipmentTextEditingController.text,
      );
      emit(
        EquipmentSuccess(
          listEquipment: equipmentResultSearch.list,
        ),
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
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
          var equipmentResult = await newBookingRepository.getNewBookingEquipmentItems(
            page: pageEquipment,
            perPage: 10,
            keywords: equipmentTextEditingController.text,
          );
          emit(
            EquipmentSuccess(
              listEquipment: equipmentResult.list,
            ),
          );
        },
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onLoadMoreEquipmentEvent(
      LoadMoreEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      var currentListEquipment = (state as EquipmentSuccess).listEquipment;
      pageEquipment += 1;
      var equipmentResult = await newBookingRepository.getNewBookingEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        keywords: equipmentTextEditingController.text,
      );
      await Future.delayed(const Duration(seconds: 1));
      if (equipmentResult.list.isEmpty) {
        equipmentRefreshController.loadFailed();
      } else {
        var newlistEquipments = List<EquipmentItem>.from(currentListEquipment)
          ..addAll(equipmentResult.list);
        equipmentRefreshController.loadComplete();
        emit(
          EquipmentSuccess(
            listEquipment: newlistEquipments,
          ),
        );
      }
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onToggleLikeEquipmentEvent(
      ToggleLikeEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      var newListEquipment = [...state.listEquipment];
      var index = newListEquipment.indexWhere((element) => element.id == event.equipmentItem.id);
      if (index >= 0) {
        var toggleLikeEquipmentResult = await newBookingRepository
            .toggleLikeNewBookingEquipmentItem(id: event.equipmentItem.id ?? 0);
        newListEquipment[index].isLiked = toggleLikeEquipmentResult.object.isLiked;
        emit(
          EquipmentLikeSuccess(
            listEquipment: newListEquipment,
            equipmentItem: event.equipmentItem,
          ),
        );
      }
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }
}
