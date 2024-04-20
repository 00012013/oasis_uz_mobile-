import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/models/equipments.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc()
      : super(EquipmentLoaded(
          [
            Equipment(name: 'Ping Pong', isChecked: false),
            Equipment(name: 'Playstation', isChecked: false),
            Equipment(name: 'Outdoor Pool', isChecked: false),
            Equipment(name: 'Winter Pool', isChecked: false),
            Equipment(name: 'Karaoke', isChecked: false),
            Equipment(name: 'Billiard', isChecked: false),
          ],
        )) {
    on<ToggleItemEvent>((event, emit) {
      List<Equipment> updatedItems = [];
      for (var equipment in [...(state as EquipmentLoaded).items]) {
        if (equipment.name == event.itemName) {
          equipment.isChecked = !equipment.isChecked;
        }
        updatedItems.add(equipment);
      }
      emit(EquipmentLoaded(updatedItems));
    });
  }

  List<String> getCheckedItems() {
    return (state as EquipmentLoaded)
        .items
        .where((equipment) => equipment.isChecked)
        .map((e) => e.name)
        .toList();
  }
}
