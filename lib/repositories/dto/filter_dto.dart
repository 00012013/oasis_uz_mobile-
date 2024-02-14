import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FilterDto {
  String? filterType;
  String? popularPLaces;
  double? maxPrice;
  double? minPrice;
  List<String>? equipments;

  FilterDto(this.filterType, this.popularPLaces, this.minPrice, this.maxPrice,
      this.equipments);
}
