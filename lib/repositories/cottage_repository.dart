import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/repositories/models/filter.dart';
import 'package:oasis_uz_mobile/util/cottage_util.dart';

class CottageRepository {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  Future<List<Cottage>> fetchCottages() async {
    final response = await http.get(Uri.parse('$api/api/cottage/get-banner'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchPopulaarCottages(int page, int size) async {
    final response = await http
        .get(Uri.parse('$api/api/cottage/get-all/?page=$page&size=$size'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchCottageByName(String name) async {
    final response = await http.get(Uri.parse('$api/api/cottage/search/$name'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
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
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<List<Cottage>> fetchFilteredCottages(Filter dto) async {
    var body = dto.toJson();
    final response = await http.post(headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(body), Uri.parse('$api/api/cottage/filter'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();

      return cottages;
    } else {
      throw Exception('Failed to load cottages');
    }
  }

  Future<bool> uploadFiles(List<Asset> files, int cottageId) async {
    List<File> filesList = await CottageUtil.assetsToFiles(files);
    var token = await _authenticationRepository.retrieveToken();

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$api/api/cottage-attachment/upload/$cottageId'));
    request.headers.addAll(headers);

    for (var file in filesList) {
      var bytes = await file.readAsBytes();
      final httpFile = http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: file.path.split('/').last,
      );
      request.files.add(httpFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadMainFile(List<Asset> files, int cottageId) async {
    List<File> filesList = await CottageUtil.assetsToFiles(files);
    var token = await _authenticationRepository.retrieveToken();

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$api/api/cottage-attachment/create-main-attachment/$cottageId'));
    request.headers.addAll(headers);
    for (var file in filesList) {
      var bytes = await file.readAsBytes();
      final httpFile = http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: file.path.split('/').last,
      );
      request.files.add(httpFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Cottage?> addCottage(Cottage cottageDTO, int userId) async {
    final url = Uri.parse('$api/api/cottage/add/$userId');
    var token = await _authenticationRepository.retrieveToken();

    final response = await http.post(
      url,
      body: jsonEncode(cottageDTO.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return Cottage.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<List<Cottage?>> getPendingCottages(int userId) async {
    var token = await _authenticationRepository.retrieveToken();
    final url = Uri.parse('$api/api/cottage/get-pending/$userId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));
      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();
      return cottages;
    } else {
      return [];
    }
  }

  Future<void> changeStatus(Cottage cottageDTO, int userId) async {
    var token = await _authenticationRepository.retrieveToken();

    final url = Uri.parse('$api/api/cottage/change-status/$userId');

    final response = await http.post(
      url,
      body: jsonEncode(cottageDTO.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
    } else {}
  }

  Future<List<Cottage?>> getUserCottages(int userId) async {
    var token = await _authenticationRepository.retrieveToken();
    final url = Uri.parse('$api/api/cottage/get/user-cottages/$userId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));
      final List<Cottage> cottages =
          jsonList.map((json) => Cottage.fromJson(json)).toList();
      return cottages;
    } else {
      return [];
    }
  }

  Future<void> updateCottage(Cottage cottageDTO, int userId) async {
    var token = await _authenticationRepository.retrieveToken();

    final response = await http.post(
      Uri.parse('$api/api/cottage-attachment/update/$userId'),
      body: jsonEncode(cottageDTO.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      print('Exception updating cottage');
    }
  }

  Future<void> removeFiles(List<int?> attachmentIds) async {
    var token = await _authenticationRepository.retrieveToken();

    final response = await http.post(
      Uri.parse('$api/api/cottage-attachment/delete-attachments'),
      body: jsonEncode(attachmentIds),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      print('Exception removing files');
    }
  }
}
