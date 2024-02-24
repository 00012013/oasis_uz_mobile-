import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/cottage/cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/isVisible/visible_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/screens/cottage_screen.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_banner_images.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/service_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final CottageRepository cottageRepository = CottageRepository();

  @override
  Widget build(BuildContext context) {
    List serviceList = [
      {
        "name": "Dacha",
        "icon": const Icon(
          Icons.house_outlined,
          color: Colors.white,
          size: 20,
        ),
        "page": ""
      },
      {
        "name": "Karaoke",
        "icon": const Icon(
          Icons.mic_external_on,
          color: Colors.white,
          size: 20,
        ),
        "page": ""
      },
      {
        "name": "PlayStation",
        "icon": const Icon(
          Icons.gamepad_outlined,
          color: Colors.white,
          size: 20,
        ),
        "page": ""
      },
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CarouselSliderBloc(),
            ),
            BlocProvider(
              create: (context) => CottageBloc(cottageRepository),
            ),
          ],
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset("assets/images/logo2.jpg"),
                      ),
                      const Text(
                        'OASIS Uz',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<CottageBloc, CottageState>(
                          builder: (context, state) {
                            if (state is CottageInitial) {
                              context
                                  .read<CottageBloc>()
                                  .add(FetchCottageEvent());
                              return Container();
                            } else if (state is CottagesLoaded) {
                              List<AppBannerImages> bannerImages = state
                                  .cottages
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
                                      viewportFraction: 1,
                                      disableCenter: true,
                                      autoPlay: true,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      onPageChanged: (index, reason) {
                                        context
                                            .read<CarouselSliderBloc>()
                                            .add(CarouselIndexChanged(index));
                                      },
                                    ),
                                  ),
                                  BlocBuilder<CarouselSliderBloc,
                                      CarouselSlidersState>(
                                    builder: (context, state) {
                                      if (state is CarouselIndexUpdated) {
                                        return DotsIndicator(
                                          dotsCount: bannerImages.length,
                                          position:
                                              state.currentIndex.toDouble(),
                                          decorator: DotsDecorator(
                                            size: const Size.square(8.0),
                                            activeSize: const Size(20.0, 8.0),
                                            color: Colors.grey,
                                            activeColor: mainColor,
                                            activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
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
                              context
                                  .read<CottageBloc>()
                                  .add(FetchCottageEvent());
                              return const Text('Cottage Loading!');
                            } else {
                              return Container();
                            }
                          },
                        ),
                        GridView.builder(
                          itemCount: serviceList.length,
                          padding: const EdgeInsets.only(bottom: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: serviceList.length,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1.4,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ServicesWidget(
                              name: serviceList[index]['name'],
                              icon: serviceList[index]['icon'],
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(15),
                          child: const CustomText(
                            text: 'Popular',
                            color: Colors.white,
                          ),
                        ),
                        BlocBuilder<PopularCottagesBlocBloc,
                            PopularCottagesBlocState>(
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
                                    const EdgeInsets.symmetric(vertical: 8),
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
                                  return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiBlocProvider(
                                                      providers: [
                                                    BlocProvider.value(
                                                      value:
                                                          CarouselSliderBloc(),
                                                    ),
                                                    BlocProvider.value(
                                                      value: VisibleBloc(),
                                                    ),
                                                  ],
                                                      child: CottageScreen(
                                                          cottages[index])),
                                            ),
                                          ),
                                      child: CottageWidget(cottages[index]));
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
