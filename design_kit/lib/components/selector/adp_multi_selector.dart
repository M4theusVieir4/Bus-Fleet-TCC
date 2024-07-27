import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPMultiSelector extends StatelessWidget {
  final OptionMultiItem item;
  final ValueChanged<int> onQuantityChanged;
  final int maxQuantity;
  final int selectedQuantity;

  const ADPMultiSelector({
    super.key,
    required this.item,
    required this.selectedQuantity,
    required this.onQuantityChanged,
    required this.maxQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.width),
      child: Column(
        children: [
          ListTile(
            title: Text(
              item.title,
              style: design.labelS(color: design.neutral),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: design
                      .labelS(color: design.neutral200)
                      .copyWith(fontSize: 13.fontSize),
                ),
                SizedBox(height: 3.height),
                Text(
                  '+${item.price.formatWithCurrency(context)}',
                  style: design
                      .h6(color: design.neutral200)
                      .copyWith(fontSize: 13.fontSize),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.imageUrl != null && selectedQuantity == 0) ...[
                  ADPImageLoadable(
                    imageUrl: item.imageUrl!,
                    width: 48.width,
                    height: 48.height,
                  ),
                ],
                selectedQuantity == 0
                    ? Center(
                        child: IconButton(
                          icon: Icon(Icons.add, color: design.primary,),
                          iconSize: 20.fontSize,
                          padding: EdgeInsets.only(
                            left: 11.width,
                            right: 3.width,
                          ),
                          constraints: const BoxConstraints(),
                          onPressed: () => onQuantityChanged(1),
                        ),
                      )
                    : Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.height,
                            horizontal: 5.width,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: design.neutral.withOpacity(0.15),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  iconSize: 18.fontSize,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.remove,
                                    color: design.primary,
                                  ),
                                  onPressed: () => onQuantityChanged(
                                    math.max(0, selectedQuantity - 1),
                                  ),
                                ),
                                SizedBox(width: 8.width),
                                Text(
                                  '$selectedQuantity',
                                  style: design.overline(color: design.neutral),
                                ),
                                SizedBox(width: 8.width),
                                IconButton(
                                  iconSize: 18.fontSize,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(Icons.add, color: design.primary,),
                                  onPressed: () => onQuantityChanged(
                                    math.min(
                                      item.quantity,
                                      selectedQuantity + 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionMultiItem {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;
  final int quantity;

  OptionMultiItem({
    this.quantity = 1,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
  });
}
