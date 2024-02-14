import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final Function(String) onSelectOption;
  const DropDownWidget(this.selectedOption, this.options, this.onSelectOption,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[400]!,
        ),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isExpanded: true,
        value: selectedOption,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        hint: const Text('Select an option'),
        onChanged: (String? newValue) {
          onSelectOption(newValue!);
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
