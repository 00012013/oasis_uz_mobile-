// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      json['filterType'] as String?,
      json['popularPlaces'] as String?,
      (json['minPrice'] as num?)?.toDouble(),
      (json['maxPrice'] as num?)?.toDouble(),
      (json['equipmentList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'filterType': instance.filterType,
      'popularPlaces': instance.popularPlaces,
      'maxPrice': instance.maxPrice,
      'minPrice': instance.minPrice,
      'equipmentList': instance.equipmentList,
    };
