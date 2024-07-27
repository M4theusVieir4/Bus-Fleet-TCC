import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class SliverFlexibleScroll extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;

  const SliverFlexibleScroll({
    super.key,
    required this.child,
    this.physics,
    this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24.width),
      child: CustomScrollView(
        physics: physics,
        controller: controller,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: child,
          ),
        ],
      ),
    );
  }
}
