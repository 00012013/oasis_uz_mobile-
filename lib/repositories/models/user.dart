import 'package:json_annotation/json_annotation.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? fullName;
  String? password;
  String? email;
  UserRole? role;

  User(this.id, this.fullName, this.password, this.email, this.role);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
