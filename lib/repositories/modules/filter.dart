import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class Filter {
  String? filterType;
  String? popularPlaces;
  double? maxPrice;
  double? minPrice;
  List<String>? equipmentList;

  Filter(this.filterType, this.popularPlaces, this.minPrice, this.maxPrice,
      this.equipmentList);
  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
