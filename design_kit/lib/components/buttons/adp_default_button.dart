import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPDefaultButton extends StatelessWidget {
  final String label;

  final TextStyle? labelStyle;

  final Color? primaryColor;

  final Color? colorLoading;

  final Color? borderColor;

  final Color? labelColor;

  final bool disable;

  final bool loading;

  final bool enablePressOnLoading;

  final bool outline;

  final Widget? iconLabel;

  final Widget? prefixIcon;

  final VoidCallback? onPressed;

  const ADPDefaultButton({
    super.key,
    required this.label,
    this.labelStyle,
    this.primaryColor,
    this.colorLoading,
    this.borderColor,
    this.labelColor,
    this.disable = false,
    this.loading = false,
    this.enablePressOnLoading = false,
    this.iconLabel,
    this.prefixIcon,
    this.outline = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    //final labelColor = !outline ? design.neutral500 : design.neutral;

    final backgroundColor = !outline ? design.primary : Colors.transparent;

    final foregroundColor =
        !outline ? design.primary200 : design.primary.withOpacity(.2);

    final defaultBorderColor =
        outline ? design.neutral.withOpacity(.2) : Colors.transparent;

    final disableBackgraundColor =
        !outline ? design.neutral400 : Colors.transparent;

    return ElevatedButton(
      onPressed: !disable ? _onPress : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 6.width),
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.maxFinite, 52.0),
        backgroundColor: primaryColor ?? backgroundColor,
        disabledBackgroundColor: disableBackgraundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor ?? defaultBorderColor),
        ),
      ),
      child: Visibility(
        visible: !loading,
        replacement: CircularProgressIndicator(
          color: design.neutral500,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: prefixIcon ?? const SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: iconLabel != null,
                  child: Row(
                    children: [
                      iconLabel ?? const SizedBox(),
                      SizedBox(width: 10.width),
                    ],
                  ),
                ),
                Text(
                  label,
                  style: labelStyle ??
                      design.buttonM(
                        color: !disable
                            ? labelColor
                            : design.neutral.withOpacity(0.4),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onPress() {
    if (!loading || enablePressOnLoading) {
      onPressed?.call();
    }
  }
}
