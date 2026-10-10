import 'package:flutter/widgets.dart';
import 'l10n.dart';

String validationMessage(BuildContext context, String code) {
  final l = context.l10n;
  final root = code.split(':').first;
  return switch (root) {
    'name_required' ||
    'at_least_one_rule' ||
    'base_missing' ||
    'matrix_incomplete' ||
    'soil_adjustment_missing' ||
    'water_adjustment_missing' ||
    'water_fallback_missing' ||
    'package_quantity_required' => l.validationRequired,
    'name_too_long' ||
    'brand_too_long' ||
    'marker_name_invalid' => l.validationNameTooLong,
    'dose_non_positive' ||
    'marker_amount_invalid' ||
    'package_quantity_invalid' ||
    'non_positive_combination' => l.validationPositive,
    'price_negative' => l.validationNonNegative,
    'currency_required' => l.validationCurrency,
    'marker_duplicate_amount' => l.validationDuplicateMarker,
    'pods_whole' => l.validationWholePods,
    'sheets_half_step' => l.validationHalfSheets,
    _ => l.errorGenericBody,
  };
}
