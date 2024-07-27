import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPMenuComponent extends StatelessWidget {
  final String priceFromLabel;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final Function(bool) onFavorite;
  final VoidCallback onTap;

  const ADPMenuComponent({
    super.key,
    required this.priceFromLabel,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: design.labelS(color: design.neutral).copyWith(
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: design.labelS(color: design.neutral200).copyWith(
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: priceFromLabel,
                      style: design
                          .labelS(color: design.neutral200)
                          .copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: price.formatWithCurrency(context),
                          style: design
                              .labelS(color: design.neutral200)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.width),
            Flexible(
              flex: 4,
              child: SizedBox(
                height: 90,
                child: Stack(
                  children: [
                    ADPImageLoadable(
                      imageUrl: imageUrl,
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: InkWell(
                        onTap: () => onFavorite(!isFavorite),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: design.neutral.withOpacity(.5),
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: design.neutral500,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
