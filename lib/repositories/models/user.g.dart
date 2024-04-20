// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['fullName'] as String?,
      json['password'] as String?,
      json['email'] as String?,
      json['role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'password': instance.password,
      'email': instance.email,
      'role': instance.role,
    };
