import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class AppBannerImages extends StatelessWidget {
  final String? imgUrl;
  final double? price;
  final String? name;

  const AppBannerImages(this.imgUrl, this.name, this.price, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width * 1,
              imageUrl: '$api/api/cottage-attachment/get-file/$imgUrl',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: Colors.black.withOpacity(0.4),
            ),
            width: MediaQuery.sizeOf(context).width * 0.45,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: name,
                    color: Colors.white,
                    weight: FontWeight.w900,
                  ),
                  CustomText(
                    text: '$price USD',
                    color: Colors.white,
                    weight: FontWeight.w900,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
