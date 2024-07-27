import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPSwitch<T> extends StatelessWidget {
  final T selected;

  final String Function(T) titleBuilder;

  final ValueChanged<T> onChanged;

  final List<T> options;

  const ADPSwitch({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.titleBuilder,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: design.neutral500,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((item) {
          final isSelected = item == selected;

          final isEven = options.indexOf(item) % 2 == 0;

          return GestureDetector(
            onTap: () => onChanged(item),
            child: AnimatedContainer(
              curve: Curves.easeIn,
              margin: EdgeInsets.only(right: isEven ? 4.0.width : 0.0),
              padding: EdgeInsets.symmetric(
                vertical: 8.0.height,
                horizontal: 14.0.width,
              ),
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: isSelected ? design.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Center(
                child: Text(
                  titleBuilder(item),
                  style: design.caption(
                    color: isSelected ? design.neutral500 : design.neutral200,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
