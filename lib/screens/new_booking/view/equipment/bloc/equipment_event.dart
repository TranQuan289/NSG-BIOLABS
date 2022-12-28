part of 'equipment_bloc.dart';

abstract class EquipmentEvent {}

class FetchDataEquipmentEvent extends EquipmentEvent {}

class SearchEquipmentEvent extends EquipmentEvent {}

class RefreshEquipmentEvent extends EquipmentEvent {}

class LoadMoreEquipmentEvent extends EquipmentEvent {}

class ToggleLikeEquipmentEvent extends EquipmentEvent {
  final EquipmentItem equipmentItem;
  ToggleLikeEquipmentEvent({
    required this.equipmentItem,
  });
}
