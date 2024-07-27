import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ADPCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final Duration fadeDuration;
  final Alignment alignment;

  const ADPCacheImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fadeDuration = const Duration(milliseconds: 0),
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fadeOutDuration: fadeDuration,
      alignment: alignment,
    );
  }
}
