import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc()
      : super(
            const DropdownState('', ["", "Option 1", "Option 2", "Option 3"])) {
    on<DropdownEvent>((event, emit) async {
      if (event is RefreshEvent) {
        emit(RefreshState(event.selectedOption, state.options));
      } else if (event is SelectOptionEvent) {
        emit(DropdownState(event.selectedOption, state.options));
      }
    });
  }
}
