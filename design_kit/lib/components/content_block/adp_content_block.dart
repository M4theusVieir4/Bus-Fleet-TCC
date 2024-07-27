import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPContentBlock extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double height;

  const ADPContentBlock({
    super.key,
    this.imageUrl = '',
    this.title = '',
    this.description = '',
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: design.neutral500,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: imageUrl.isNotEmpty,
              replacement: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: design.labelS(color: design.neutral).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 4.height),
                    Text(
                      description,
                      style: design.caption(color: design.neutral200),
                    ),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ADPImageLoadable(
                  imageUrl: imageUrl,
                  height: height,
                  width: double.maxFinite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
