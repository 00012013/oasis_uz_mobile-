part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object> get props => [];
}

class SelectOptionEvent extends DropdownEvent {
  final String selectedOption;

  const SelectOptionEvent(this.selectedOption);
}

class RefreshEvent extends DropdownEvent {
  final String selectedOption;
  const RefreshEvent(this.selectedOption);
}
