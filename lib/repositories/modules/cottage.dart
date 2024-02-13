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
  List<DateTime>? bookedDates = [];
  final Attachment? mainAttachment;
  final List<Attachment>? attachmentsList;
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
    this.attachmentsList,
    this.isFavorite = false,
  });

  factory Cottage.fromJson(Map<String, dynamic> json) =>
      _$CottageFromJson(json);

  Map<String, dynamic> toJson() => _$CottageToJson(this);
}
