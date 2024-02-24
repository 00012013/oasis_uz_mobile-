import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oasis_uz_mobile/bloc/filter_cottage/filter_cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';
import 'package:oasis_uz_mobile/widgets/custom_image.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class CottageWidget extends StatefulWidget {
  final Cottage cottage;

  const CottageWidget(this.cottage, {super.key});

  @override
  State<CottageWidget> createState() => _CottageWidgetState();
}

class _CottageWidgetState extends State<CottageWidget> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.19),
            spreadRadius: 0.5,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: SizedBox(
                  height: screenHeight * 0.18,
                  child: widget.cottage.mainAttachment != null
                      ? CustomImage(
                          widget.cottage.mainAttachment!.id.toString(),
                          10,
                          false)
                      : null,
                ),
              ),
              IconButton(
                icon: Icon(
                  widget.cottage.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    BlocProvider.of<PopularCottagesBlocBloc>(context)
                        .add(ToggleFavoriteEvent(widget.cottage.id!));
                    BlocProvider.of<FilterCottageBloc>(context)
                        .add(const FilterCottage(null));
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.cottage.name,
                  size: 18,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (double value) {},
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: "${widget.cottage.weekDaysPrice} USD",
                  weight: FontWeight.w500,
                  color: mainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
