import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/attachment.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';

part 'cottage_state.dart';

class CottageCubit extends Cubit<Cottage> {
  final CottageRepository _cottageRepository = CottageRepository();
  CottageCubit()
      : super(
          Cottage(
            mainAttachment: const Attachment(),
            attachmentsList: [],
            name: '',
            weekDaysPrice: 0,
            weekendDaysPrice: 0,
            description: '',
            guestCount: 0,
            latitude: null,
            longitude: null,
            totalRoomCount: null,
            equipmentsList: null,
          ),
        );

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateWeekdayPrice(double price) {
    emit(state.copyWith(weekDaysPrice: price));
  }

  void updateWeekendPrice(double price) {
    emit(state.copyWith(weekendDaysPrice: price));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateLatitude(double latitude) {
    emit(state.copyWith(latitude: latitude));
  }

  void updateLongitude(double longitude) {
    emit(state.copyWith(longitude: longitude));
  }

  void updateTotalRoomCount(int room) {
    emit(state.copyWith(totalRoomCount: room));
  }

  void updateEquipmentList(List<String> equipment) {
    emit(state.copyWith(equipmentsList: equipment));
  }

  Future<String?> fetchAddress(double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$clientId';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final results = decodedResponse['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          return results.first['formatted_address'] as String?;
        }
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
    return null;
  }

  void removeData() {
    emit(
      state.copyWith(
        attachmentsList: [],
        name: '',
        weekDaysPrice: 0,
        weekendDaysPrice: 0,
        description: '',
        guestCount: 0,
        latitude: null,
        longitude: null,
        totalRoomCount: null,
        equipmentsList: null,
      ),
    );
  }

  Future<void> addCottage(Cottage cottageDTO, int userId, List<Asset> files,
      List<Asset> mainFile, BuildContext context) async {
    Cottage? cottage = await _cottageRepository.addCottage(cottageDTO, userId);
    if (cottage != null) {
      _cottageRepository.uploadFiles(files, cottage.id!);
      _cottageRepository.uploadMainFile(mainFile, cottage.id!);
      CustomSnackBar(backgroundColor: Colors.green).showError(
        context,
        "Saved",
      );

      return;
    }
    CustomSnackBar(backgroundColor: Colors.red).showError(
      context,
      "Failed to save",
    );
  }

  Future<void> updateCottage(
      Cottage cottageDTO,
      int userId,
      Object? mainFile,
      List<Object?> attachments,
      List<int> removedAttachments,
      BuildContext context) async {
    try {
      _cottageRepository.updateCottage(cottageDTO, userId);

      if (removedAttachments.isNotEmpty) {
        _cottageRepository.removeFiles(removedAttachments);
      }
      if (mainFile is List<Asset> && mainFile.isNotEmpty) {
        _cottageRepository.uploadMainFile(mainFile, cottageDTO.id!);
      }
      if (attachments is List<Asset> && attachments.isNotEmpty) {
        _cottageRepository.uploadFiles(attachments, cottageDTO.id!);
      }
      // ignore: use_build_context_synchronously
      CustomSnackBar(backgroundColor: Colors.green).showError(
        context,
        "Saved",
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(backgroundColor: Colors.red).showError(
        context,
        "Failed to update",
      );
    }
  }
}
