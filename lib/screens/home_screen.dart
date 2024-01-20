import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/cottage/cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_banner_images.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          BlocProvider(
            create: (context) => PopularCottagesBlocBloc(cottageRepository),
          )
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CottageBloc, CottageState>(
              builder: (context, state) {
                if (state is CottageInitial) {
                  context.read<CottageBloc>().add(FetchCottageEvent());
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      strokeWidth: 4,
                    ),
                  );
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[800],
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

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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
                      childAspectRatio: 0.7,
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
