// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDto _$TokenDtoFromJson(Map<String, dynamic> json) => TokenDto(
      json['accessToken'] as String?,
      json['refreshToken'] as String?,
    );

Map<String, dynamic> _$TokenDtoToJson(TokenDto instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
