import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../translation/all_translation.dart';

extension Translate on String {
  String get tr => allTranslations.text(this);
}

extension EmptyPadding on num {
  SizedBox get sbH => SizedBox(height: toDouble());
  SizedBox get sbW => SizedBox(width: toDouble());
}

extension DateHelpers on DateTime {
  String toDateFormat({String? format, String? locale}) {
    final formatter =
        intl.DateFormat(format ?? 'EE, d MMM hh:mm', locale ?? 'en');
    return formatter.format(this);
  }
}
