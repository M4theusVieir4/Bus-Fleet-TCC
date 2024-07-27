import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatWithCurrency(
    BuildContext context,
  ) {
    var locale = Localizations.localeOf(context);

    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      decimalDigits: 2,
      symbol: 'R\$',
    );

    return formatter.format(this);
  }
}
