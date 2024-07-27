import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ADPChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 8.width),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: design.neutral.withOpacity(0.15),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(78),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: design.labelS(color: design.neutral200).copyWith(height: 1),
          ),
        ),
      ),
    );
  }
}
