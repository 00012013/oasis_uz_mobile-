part of 'equipment_bloc.dart';

abstract class EquipmentState {
  const EquipmentState();
}

class EquipmentLoaded extends EquipmentState {
  final List<Equipment> items;

  const EquipmentLoaded(this.items);
}
