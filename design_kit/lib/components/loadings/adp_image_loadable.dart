import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPImageLoadable extends StatelessWidget {
  final String? imageUrl;
  final double? iconErrorSize;
  final double borderRadius;
  final double width;
  final double height;
  final BoxFit fit;
  final Alignment alignment;

  const ADPImageLoadable({
    super.key,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
    this.iconErrorSize = 25,
    this.borderRadius = 8,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: imageUrl != null && imageUrl!.isNotEmpty,
      replacement: Icon(
        Icons.broken_image_rounded,
        size: iconErrorSize,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: width,
          height: height,
          fadeOutDuration: const Duration(milliseconds: 1000),
          fadeInDuration: const Duration(milliseconds: 500),
          fit: fit,
          alignment: alignment,
          placeholder: (_, __) => ColoredBox(
            color: Colors.transparent,
            child: ADPShimmer(width: width, height: height),
          ),
          errorWidget: (_, __, ___) => Icon(
            Icons.broken_image_rounded,
            size: iconErrorSize,
          ),
        ),
      ),
    );
  }
}
