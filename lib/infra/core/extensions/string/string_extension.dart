import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

extension StringExtension on String {
  String translate([List<String> args = const []]) => i18n(args);

  Color fromHex() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  bool onlyNumbers() => double.tryParse(this) != null;

  bool? toBool() {
    if (this == 'true') {
      return true;
    }
    if (this == 'false') {
      return false;
    }
    return null;
  }
}
