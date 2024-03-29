import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.wishlist,
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
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
                                height:
                                    MediaQuery.sizeOf(context).height * 0.3),
                            Icon(
                              Icons.favorite_border,
                              color: mainColor,
                              size: 40,
                            ),
                            CustomText(
                              text: AppLocalizations.of(context)!.wishlistEmpty,
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
      ),
    );
  }
}
