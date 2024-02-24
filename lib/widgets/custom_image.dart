import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';

// ignore: must_be_immutable
class CustomImage extends StatelessWidget {
  final String imgUrl;
  double borderRadius = 10;
  bool all;
  CustomImage(this.imgUrl, this.borderRadius, this.all, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: all == false
          ? BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            )
          : BorderRadius.all(
              Radius.circular(borderRadius),
            ),
      child: CachedNetworkImage(
        width: MediaQuery.sizeOf(context).width * 1,
        imageUrl: '$api/api/cottage-attachment/get-file/$imgUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}
