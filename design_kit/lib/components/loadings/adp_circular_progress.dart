import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPCircularProgress extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;

  const ADPCircularProgress({
    super.key,
    this.color,
    this.size = 60,
    this.strokeWidth = 8,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color ?? design.primary,
          strokeWidth: strokeWidth,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
