import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPCheckbox extends StatelessWidget {
  final String label;

  final List<Widget> textSpan;

  final void Function(bool?)? onValue;

  final bool formValue;

  final bool error;

  const ADPCheckbox({
    super.key,
    this.label = '',
    this.textSpan = const [],
    this.onValue,
    required this.formValue,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
            visualDensity: VisualDensity.comfortable,
            value: formValue,
            onChanged: onValue,
            checkColor: design.neutral500,
            fillColor: MaterialStatePropertyAll(
              formValue ? design.primary : design.neutral500,
            ),
            side: BorderSide(
              color: error ? design.error100 : design.neutral,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(width: 10.width),
        Expanded(
          child: Visibility(
            visible: label.isNotEmpty || textSpan.isEmpty,
            replacement: Wrap(children: textSpan),
            child: Text(
              label,
              style: design
                  .labelS(
                    color: design.neutral.withOpacity(
                      onValue == null ? 0.5 : 1,
                    ),
                  )
                  .copyWith(height: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
