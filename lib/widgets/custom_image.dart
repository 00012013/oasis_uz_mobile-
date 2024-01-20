import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';

class CustomImage extends StatelessWidget {
  final String imgUrl;
  double borderRadius = 10;

  CustomImage(this.imgUrl, this.borderRadius, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius)),
      child: CachedNetworkImage(
        width: MediaQuery.sizeOf(context).width * 1,
        imageUrl: '$api/api/cottage-attachment/get-file/$imgUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}
