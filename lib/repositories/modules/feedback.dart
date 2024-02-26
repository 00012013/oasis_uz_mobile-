import 'package:json_annotation/json_annotation.dart';
part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  String fullName;
  String phoneNumber;
  String message;

  Feedback(this.fullName, this.phoneNumber, this.message);
  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
