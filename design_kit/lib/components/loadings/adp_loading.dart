import 'package:flutter/material.dart';

import '../../design_kit.dart';

bool _isShowing = false;

class ADPLoading {
  static void show(
    BuildContext context, {
    required bool show,
  }) {
    final design = DesignSystem.of(context);

    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: design.neutral.withOpacity(.15),
        builder: (_) {
          _isShowing = true;
          return const ADPCircularProgress();
        },
      );
    } else {
      if (_isShowing) {
        Navigator.pop(context);
        _isShowing = false;
      }
    }
  }
}
