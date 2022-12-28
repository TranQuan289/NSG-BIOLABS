part of 'equipment_bloc.dart';

abstract class EquipmentState {
  final List<EquipmentItem> listEquipment;
  EquipmentState({
    required this.listEquipment,
  });
}

class EquipmentInitial extends EquipmentState {
  EquipmentInitial({required super.listEquipment});
}

class EquipmentSuccess extends EquipmentState {
  EquipmentSuccess({required super.listEquipment});
}

class EquipmentLikeSuccess extends EquipmentState {
  final EquipmentItem equipmentItem;
  EquipmentLikeSuccess({required super.listEquipment, required this.equipmentItem});
}

class EquipmentError extends EquipmentState {
  final String errorMessage;
  EquipmentError({required super.listEquipment, required this.errorMessage});
}
