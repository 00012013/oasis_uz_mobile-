import 'package:json_annotation/json_annotation.dart';
import 'package:oasis_uz_mobile/repositories/modules/attachment.dart';

part 'cottage.g.dart';

@JsonSerializable(explicitToJson: true)
class Cottage {
  final int? id;
  final String? name;
  final String? description;
  final double? weekDaysPrice;
  final double? weekendDaysPrice;
  final double? latitude;
  final double? longitude;
  final int? guestCount;
  final int? totalRoomCount;
  final List<String>? equipmentsList;
  final List<DateTime>? bookedDates;
  final Attachment? mainAttachment;
  bool isFavorite;

  Cottage({
    this.id,
    this.name,
    this.description,
    this.weekDaysPrice,
    this.weekendDaysPrice,
    this.latitude,
    this.longitude,
    this.guestCount,
    this.totalRoomCount,
    this.equipmentsList,
    this.bookedDates,
    this.mainAttachment,
    this.isFavorite = false,
  });

  factory Cottage.fromJson(Map<String, dynamic> json) =>
      _$CottageFromJson(json);

  Map<String, dynamic> toJson() => _$CottageToJson(this);
}
