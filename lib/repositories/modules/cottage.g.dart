// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cottage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cottage _$CottageFromJson(Map<String, dynamic> json) => Cottage(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      weekDaysPrice: (json['weekDaysPrice'] as num?)?.toDouble(),
      weekendDaysPrice: (json['weekendDaysPrice'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      guestCount: json['guestCount'] as int?,
      totalRoomCount: json['totalRoomCount'] as int?,
      equipmentsList: (json['equipmentsList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bookedDates: (json['bookedDates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      mainAttachment: json['mainAttachment'] == null
          ? null
          : Attachment.fromJson(json['mainAttachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CottageToJson(Cottage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'weekDaysPrice': instance.weekDaysPrice,
      'weekendDaysPrice': instance.weekendDaysPrice,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'guestCount': instance.guestCount,
      'totalRoomCount': instance.totalRoomCount,
      'equipmentsList': instance.equipmentsList,
      'bookedDates':
          instance.bookedDates?.map((e) => e.toIso8601String()).toList(),
      'mainAttachment': instance.mainAttachment?.toJson(),
    };
