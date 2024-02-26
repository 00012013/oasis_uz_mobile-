import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/modules/feedback.dart';

class FeedbackRepository {
  Future<void> submitFeedback(Feedback feedback) async {
    try {
      String jsonBody = jsonEncode(feedback.toJson());

      var response = await http.post(
        Uri.parse('$api/api/feedback/send/1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody,
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to submit feedback');
      }
    } catch (e) {
      rethrow;
    }
  }
}
