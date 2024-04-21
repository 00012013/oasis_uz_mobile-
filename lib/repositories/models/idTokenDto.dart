import 'package:json_annotation/json_annotation.dart';

part 'idTokenDto.g.dart';

@JsonSerializable()
class IdTokenDto {
  final String tokenId;

  IdTokenDto(this.tokenId);

  factory IdTokenDto.fromJson(Map<String, dynamic> json) =>
      _$IdTokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IdTokenDtoToJson(this);
}
