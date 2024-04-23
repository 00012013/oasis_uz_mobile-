import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/widgets/custom_banner_images.dart';

part 'cottage_event.dart';
part 'cottage_state.dart';

class CottageBloc extends Bloc<CottageEvent, CottageState> {
  final CottageRepository cottageRepository;

  CottageBloc(this.cottageRepository) : super(CottageInitial()) {
    on<CottageEvent>((event, emit) async {
      if (event is FetchCottageEvent) {
        try {
          final List<Cottage> cottages =
              await cottageRepository.fetchCottages();
          List<AppBannerImages> bannerImages = cottages
              .map(
                (cottage) => AppBannerImages(
                    cottage.mainAttachment!.id.toString(),
                    cottage.name,
                    cottage.weekDaysPrice),
              )
              .toList();
          emit(CottagesLoaded(bannerImages));
        } catch (e) {
          throw Exception(e);
        }
      }
    });
  }
}
