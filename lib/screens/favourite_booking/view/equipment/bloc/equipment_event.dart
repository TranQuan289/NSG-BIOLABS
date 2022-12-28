part of 'equipment_bloc.dart';

abstract class EquipmentEvent {}

class FetchDataEquipmentEvent extends EquipmentEvent {}

class ToggleLikeEquipmentEvent extends EquipmentEvent {
  final EquipmentItem favouriteEquipment;

  ToggleLikeEquipmentEvent({
    required this.favouriteEquipment,
  });
}

class RefreshEquipmentEvent extends EquipmentEvent {}

class LoadMoreEquipmentEvent extends EquipmentEvent {}
