import 'package:flutter/material.dart';

import '../design_kit.dart';

extension ScaffoldExtension on Scaffold {
  ADPFlavorBanner addBanner(String flavorName) {
    return ADPFlavorBanner(flavorName: flavorName, child: this);
  }
}
