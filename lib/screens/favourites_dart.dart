import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader("Wishlist"),
            BlocBuilder<PopularCottagesBlocBloc, PopularCottagesBlocState>(
              builder: (context, state) {
                if (state is PopularCottagesLoaded) {
                  var cottages =
                      state.cottages.where((e) => e.isFavorite).toList();
                  if (cottages.isNotEmpty) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
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
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.825,
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.3),
                          Icon(
                            Icons.favorite_border,
                            color: mainColor,
                            size: 40,
                          ),
                          const CustomText(
                            text: 'Wish list is empty',
                            color: Colors.black,
                            size: 18,
                          )
                        ],
                      ),
                    );
                  }
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
