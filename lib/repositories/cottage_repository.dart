import 'dart:convert';

import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/dto/filter_dto.dart';
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

  Future<List<String>> fetchCottageNameByName(String name) async {
    final response = await http.get(Uri.parse('$api/api/cottage/search/$name'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<String> cottagesName =
          jsonList.map((json) => json.toString()).toList();

      return cottagesName;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchFavoriteCottages(
      List<int> favoriteCottageIds) async {
    final Map<String, dynamic> requestBody = {
      'cottageList': favoriteCottageIds,
    };

    final response = await http.post(
      Uri.parse('$api/api/cottage/get/cottage-list'),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchFilteredCottages(FilterDto dto) async {
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
}
