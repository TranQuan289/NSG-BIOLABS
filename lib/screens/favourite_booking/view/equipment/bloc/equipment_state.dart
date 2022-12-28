part of 'equipment_bloc.dart';

abstract class EquipmentState {}

class EquipmentInitial extends EquipmentState {}

class EquipmentSuccess extends EquipmentState {
    final List<EquipmentItem> listEquipment;
  EquipmentSuccess({
    required this.listEquipment,
  });
}

class EquipmentLikeSuccess extends EquipmentState {
  final EquipmentItem favouriteEquipment;
  EquipmentLikeSuccess({
    required this.favouriteEquipment,
  });
}

class EquipmentError extends EquipmentState {
  final String errorMessage;
  EquipmentError({
    required this.errorMessage,
  });
}
