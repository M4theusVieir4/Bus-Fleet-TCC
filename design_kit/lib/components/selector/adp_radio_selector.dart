import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPRadioSelector<T> extends StatelessWidget {
  final T id;
  final T groupId;
  final void Function(T?) onChanged;
  final String title;
  final String description;
  final double price;
  final bool isDisabled;
  final String? imageUrl;

  const ADPRadioSelector({
    super.key,
    required this.id,
    required this.groupId,
    required this.onChanged,
    required this.title,
    required this.description,
    required this.price,
    this.isDisabled = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return ListTile(
      title: Text(
        title,
        style: design.labelS(color: design.neutral),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: design
                .labelS(color: design.neutral200)
                .copyWith(fontSize: 13.fontSize),
          ),
          SizedBox(height: 3.height),
          Text(
            '+${price.formatWithCurrency(context)}',
            style: design
                .h6(color: design.neutral200)
                .copyWith(fontSize: 13.fontSize),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageUrl != null) ...[
            ADPImageLoadable(
              imageUrl: imageUrl,
              width: 48.width,
              height: 48.height,
            ),
            SizedBox(width: 15.width),
          ],
          Center(
            child: ADPRadioButton<T>(
              id: id,
              groupId: groupId,
              onChanged: isDisabled ? (_) {} : onChanged,
              isDisabled: isDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
