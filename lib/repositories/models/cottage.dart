import 'package:json_annotation/json_annotation.dart';
import 'package:oasis_uz_mobile/repositories/enums/status.dart';
import 'package:oasis_uz_mobile/repositories/models/attachment.dart';

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
  final Status status;
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
    this.status = Status.APPROVED,
  });

  Cottage copyWith({
    List<Attachment>? attachmentsList,
    String? name,
    double? weekDaysPrice,
    double? weekendDaysPrice,
    String? description,
    double? latitude,
    double? longitude,
    int? guestCount,
    int? totalRoomCount,
    List<String>? equipmentsList,
    List<DateTime>? bookedDates,
    bool? isFavorite,
  }) {
    return Cottage(
      attachmentsList: attachmentsList ?? this.attachmentsList,
      name: name ?? this.name,
      weekDaysPrice: weekDaysPrice ?? this.weekDaysPrice,
      weekendDaysPrice: weekendDaysPrice ?? this.weekendDaysPrice,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      guestCount: guestCount ?? this.guestCount,
      totalRoomCount: totalRoomCount ?? this.totalRoomCount,
      equipmentsList: equipmentsList ?? this.equipmentsList,
      bookedDates: bookedDates ?? this.bookedDates,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Cottage.fromJson(Map<String, dynamic> json) =>
      _$CottageFromJson(json);

  Map<String, dynamic> toJson() => _$CottageToJson(this);
}
