class Equipment {
  final String name;
  bool isChecked;

  Equipment({required this.name, this.isChecked = false});

  Equipment copyWith({int? id, String? name, bool? isChecked}) {
    return Equipment(
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
