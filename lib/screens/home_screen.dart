import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/cottage/cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_banner_images.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/service_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List serviceList = [
      {
        "name": "Dacha",
        "icon": const Icon(
          Icons.house_outlined,
          color: Colors.white,
        ),
        "page": ""
      },
      {
        "name": "Karaoke",
        "icon": const Icon(Icons.mic_external_on, color: Colors.white),
        "page": ""
      },
      {
        "name": "PlayStation",
        "icon": const Icon(Icons.gamepad_outlined, color: Colors.white),
        "page": ""
      },
    ];
    final CottageRepository cottageRepository = CottageRepository();
    return SingleChildScrollView(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CarouselSliderBloc(),
          ),
          BlocProvider(
            create: (context) => CottageBloc(cottageRepository),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              itemCount: serviceList.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: serviceList.length,
                crossAxisSpacing: 20,
                childAspectRatio: 1.7,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ServicesWidget(
                  name: serviceList[index]['name'],
                  icon: serviceList[index]['icon'],
                );
              },
            ),
            BlocBuilder<CottageBloc, CottageState>(
              builder: (context, state) {
                if (state is CottageInitial) {
                  context.read<CottageBloc>().add(FetchCottageEvent());
                  return Container();
                } else if (state is CottagesLoaded) {
                  List<AppBannerImages> bannerImages = state.cottages
                      .map(
                        (cottage) => AppBannerImages(
                            cottage.mainAttachment!.id.toString(),
                            cottage.name,
                            cottage.weekDaysPrice),
                      )
                      .toList();
                  return Column(
                    children: [
                      CarouselSlider(
                        items: bannerImages,
                        options: CarouselOptions(
                          height: 200,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          disableCenter: true,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayInterval: const Duration(seconds: 5),
                          onPageChanged: (index, reason) {
                            context
                                .read<CarouselSliderBloc>()
                                .add(CarouselIndexChanged(index));
                          },
                        ),
                      ),
                      BlocBuilder<CarouselSliderBloc, CarouselSlidersState>(
                        builder: (context, state) {
                          if (state is CarouselIndexUpdated) {
                            return DotsIndicator(
                              dotsCount: bannerImages.length,
                              position: state.currentIndex.toDouble(),
                              decorator: DotsDecorator(
                                size: const Size.square(8.0),
                                activeSize: const Size(20.0, 8.0),
                                color: Colors.grey,
                                activeColor: mainColor,
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } else if (state is CottageLoading) {
                  context.read<CottageBloc>().add(FetchCottageEvent());
                  return const Text('Cottage Loading!');
                } else {
                  return Container();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(15),
                child: const CustomText(
                  text: 'Popular',
                ),
              ),
            ),
            BlocBuilder<PopularCottagesBlocBloc, PopularCottagesBlocState>(
              builder: (context, state) {
                if (state is PopularCottagesBlocInitial) {
                  context
                      .read<PopularCottagesBlocBloc>()
                      .add(FetchPopularCottageEvent());

                  return Container();
                } else if (state is PopularCottagesLoaded) {
                  var cottages = state.cottages;
                  return GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: cottages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      return CottageWidget(cottages[index]);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
