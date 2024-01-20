import 'dart:convert';

import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';
import 'package:http/http.dart' as http;

class CottageRepository {
  Future<List<Cottage>> fetchCottages() async {
    final response = await http.get(Uri.parse('$api/api/cottage/get-banner'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchPopulaarCottages() async {
    final response = await http.get(Uri.parse('$api/api/cottage/get-all'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }
}
