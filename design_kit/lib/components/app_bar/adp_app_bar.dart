import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final double elevation;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  const ADPAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.elevation = 0,
    this.leading,
    this.actions,
    this.onBackPressed,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final backPressed = onBackPressed ?? Navigator.of(context).pop;

    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor ?? design.neutral700,
      elevation: elevation,
      leading: leading ??
          Padding(
            padding: EdgeInsets.only(left: 16.0.width),
            child: BackButton(
              color: design.neutral900,
              onPressed: backPressed,
            ),
          ),
      title: title,
      actions: actions,
    );
  }
}
