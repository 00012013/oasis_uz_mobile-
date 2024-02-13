part of 'dropdown_bloc.dart';

sealed class DropdownState extends Equatable {
  const DropdownState();

  @override
  List<Object> get props => [];
}

class OptionSelectedState extends DropdownState {
  final String selectedOption;

  const OptionSelectedState(this.selectedOption);
}
