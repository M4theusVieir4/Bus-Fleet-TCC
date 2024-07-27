import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../design_kit.dart';

class ADPShimmer extends StatelessWidget {
  final double width;

  final double height;

  final EdgeInsets margin;

  final Widget? child;

  final BoxShape shape;

  final Color? baseColor;

  final Color? highlightColor;

  const ADPShimmer({
    super.key,
    required this.width,
    required this.height,
    this.margin = const EdgeInsets.all(0),
    this.child,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Shimmer.fromColors(
      baseColor: baseColor ?? design.neutral500.withOpacity(0.8),
      highlightColor: highlightColor ?? design.neutral400,
      child: child == null
          ? Container(
              width: width,
              height: height,
              margin: margin,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: shape == BoxShape.rectangle
                    ? BorderRadius.circular(4)
                    : null,
                shape: shape,
              ),
            )
          : child!,
    );
  }
}
