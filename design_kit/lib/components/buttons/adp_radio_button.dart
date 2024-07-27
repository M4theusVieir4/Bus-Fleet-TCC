import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPRadioButton<T> extends StatelessWidget {
  final T id;
  final T groupId;
  final void Function(T?) onChanged;
  final bool isDisabled;

  const ADPRadioButton({
    super.key,
    required this.id,
    required this.groupId,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    final isSelected = id == groupId;

    final outerColor = isSelected ? design.primary : design.neutral;
    final borderColor = isDisabled ? outerColor.withOpacity(0.5) : outerColor;
    final borderWidth = isSelected ? 6.0 : 1.5;

    return InkWell(
      onTap: isDisabled ? null : () => onChanged(id),
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 20,
        height: 20,
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: borderColor,
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: design.neutral500,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
