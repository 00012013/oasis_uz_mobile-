import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';
import 'package:oasis_uz_mobile/widgets/custom_image.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class CottageWidget extends StatelessWidget {
  final Cottage cottage;

  const CottageWidget(this.cottage, {super.key});

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
          FractionallySizedBox(
            widthFactor: 1,
            child: SizedBox(
              height: screenHeight * 0.18,
              child: CustomImage(cottage.mainAttachment!.id.toString(), 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: cottage.name,
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
                  text: "${cottage.weekDaysPrice} USD",
                  weight: FontWeight.w500,
                  color: Colors.deepPurple[800]!,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
