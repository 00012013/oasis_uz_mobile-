part of 'dropdown_bloc.dart';

class DropdownState extends Equatable {
  final String selectedOption;
  final List<String> options;

  const DropdownState(this.selectedOption, this.options);

  @override
  List<Object> get props => [];
}

class RefreshState extends DropdownState {
  const RefreshState(super.selectedOption, super.options);
}
