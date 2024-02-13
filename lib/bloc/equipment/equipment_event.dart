part of 'equipment_bloc.dart';

sealed class EquipmentEvent {
  const EquipmentEvent();
}

class ToggleItemEvent extends EquipmentEvent {
  final String itemName;

  const ToggleItemEvent(this.itemName);
}
