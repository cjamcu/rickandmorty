import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarCached extends StatelessWidget {
  const AvatarCached({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });
  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => const SizedBox(),
      errorWidget: (context, url, error) => const SizedBox(),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
        ),
      ),
    );
  }
}
