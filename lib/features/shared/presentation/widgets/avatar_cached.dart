import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarCached extends StatelessWidget {
  const AvatarCached({
    super.key,
    required this.imageUrl,
    required this.size,
  });
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size,
      height: size,
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
