import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPDefaultTextButton extends StatelessWidget {
  final List<TextPart>? labelParts;
  final String? label;
  final Color? textColor;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final TextStyle? labelStyle;

  const ADPDefaultTextButton({
    super.key,
    this.labelParts,
    this.label,
    this.textColor,
    this.icon,
    this.onPressed,
    this.isDisabled = false,
    this.labelStyle,
  }) : assert(
          labelParts != null || label != null,
        );

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final bool shouldDisableButton = isDisabled || onPressed == null;
    final Color defaultTextColor = textColor ?? design.neutral;
    final Color disabledTextColor = design.neutral.withOpacity(0.4);
    final Color effectiveTextColor =
        shouldDisableButton ? disabledTextColor : defaultTextColor;

    return TextButton(
      onPressed: shouldDisableButton ? null : onPressed,
      style: ButtonStyle(
        animationDuration: Duration.zero,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return design.primary.withOpacity(0.25);
            }
            return null;
          },
        ),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(width: 8.width),
          ],
          Align(
            alignment: Alignment.center,
            child: label != null
                ? Text(
                    label!,
                    style: labelStyle ??
                        design.buttonS(
                          color: effectiveTextColor,
                        ),
                  )
                : RichText(
                    text: TextSpan(
                      children: labelParts!
                          .map(
                            (part) => TextSpan(
                              text: part.label,
                              style: labelStyle ??
                                  design.buttonS(
                                    color: part.color != null
                                        ? (shouldDisableButton
                                            ? disabledTextColor
                                            : part.color)
                                        : effectiveTextColor,
                                  ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class TextPart {
  final String label;
  final Color? color;

  TextPart(this.label, {this.color});
}
