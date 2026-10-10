import '../domain/detergent_draft.dart';
import '../domain/enums.dart';

class DraftValidationResult {
  const DraftValidationResult({
    this.errors = const [],
    this.warnings = const [],
  });
  final List<String> errors;
  final List<String> warnings;
  bool get isValid => errors.isEmpty;
}

class DraftValidator {
  const DraftValidator._();

  static DraftValidationResult validate(DetergentDraft d) {
    final errors = <String>[];
    final warnings = <String>[];
    if (d.name.trim().isEmpty) errors.add('name_required');
    if (d.name.trim().runes.length > 60) errors.add('name_too_long');
    if (d.brand.trim().runes.length > 60) errors.add('brand_too_long');

    if (d.ruleStrategy == RuleStrategy.matrix) {
      for (final key in d.requiredMatrixKeys()) {
        if (!d.matrixValues.containsKey(key) &&
            !d.matrixNotListed.contains(key)) {
          errors.add('matrix_incomplete:$key');
        }
      }
      if (d.matrixValues.isEmpty) errors.add('at_least_one_rule');
      for (final amount in d.matrixValues.values) {
        _validateDose(d, amount, errors, warnings);
      }
    } else {
      var baseCount = 0;
      for (final load in d.activeLoads) {
        final amount = d.baseValues[DetergentDraft.baseKey(load)];
        if (amount == null) {
          errors.add('base_missing:${DetergentDraft.baseKey(load)}');
          continue;
        }
        baseCount++;
        _validateDose(d, amount, errors, warnings);
      }
      if (baseCount == 0) errors.add('at_least_one_rule');
      if (d.soilEnabled) {
        for (final x in SoilLevel.values) {
          if (!d.soilAdjustments.containsKey(x.name)) {
            errors.add('soil_adjustment_missing:${x.name}');
          }
        }
      }
      if (d.waterEnabled) {
        for (final x in [WaterLevel.soft, WaterLevel.medium, WaterLevel.hard]) {
          if (!d.waterAdjustments.containsKey(x.name)) {
            errors.add('water_adjustment_missing:${x.name}');
          }
        }
        if (d.unknownWaterFallback == null) {
          errors.add('water_fallback_missing');
        }
      }
      // Every reachable base+adjustment result must remain positive.
      for (final load in d.activeLoads) {
        final base = d.baseValues[DetergentDraft.baseKey(load)];
        if (base == null) continue;
        final soils = d.soilEnabled
            ? SoilLevel.values.map((x) => d.soilAdjustments[x.name])
            : const [0.0];
        final waters = d.waterEnabled
            ? [
                WaterLevel.soft,
                WaterLevel.medium,
                WaterLevel.hard,
              ].map((x) => d.waterAdjustments[x.name])
            : const [0.0];
        for (final s in soils) {
          for (final w in waters) {
            if (s == null || w == null) continue;
            if (base + s + w <= 0) errors.add('non_positive_combination');
          }
        }
      }
    }

    if (d.packagePrice != null && d.packagePrice! < 0) {
      errors.add('price_negative');
    }
    if (d.packagePrice != null && d.packageQuantityCanonical == null) {
      errors.add('package_quantity_required');
    }
    if (d.packageQuantityCanonical != null &&
        d.packageQuantityCanonical! <= 0) {
      errors.add('package_quantity_invalid');
    }
    if (d.packagePrice != null &&
        (d.currencyCode == null || d.currencyCode!.trim().isEmpty)) {
      errors.add('currency_required');
    }

    final sorted = [...d.markers]
      ..sort((a, b) => a.amountCanonical.compareTo(b.amountCanonical));
    final seenAmounts = <double>{};
    for (final m in sorted) {
      if (m.label.trim().isEmpty || m.label.trim().runes.length > 24) {
        errors.add('marker_name_invalid');
      }
      if (!m.amountCanonical.isFinite || m.amountCanonical <= 0) {
        errors.add('marker_amount_invalid');
      }
      if (!seenAmounts.add(m.amountCanonical)) {
        errors.add('marker_duplicate_amount');
      }
    }
    return DraftValidationResult(
      errors: errors.toSet().toList(),
      warnings: warnings.toSet().toList(),
    );
  }

  static void _validateDose(
    DetergentDraft d,
    double amount,
    List<String> errors,
    List<String> warnings,
  ) {
    if (!amount.isFinite || amount <= 0) {
      errors.add('dose_non_positive');
      return;
    }
    if (d.type == DetergentType.pod && (amount - amount.round()).abs() > 1e-9) {
      errors.add('pods_whole');
    }
    if (d.type == DetergentType.sheet &&
        ((amount * 2) - (amount * 2).round()).abs() > 1e-9) {
      errors.add('sheets_half_step');
    }
    final unusual = switch (d.type) {
      DetergentType.liquid => amount > 1000,
      DetergentType.powder =>
        d.canonicalUnit == CanonicalUnit.g ? amount > 1000 : amount > 20,
      DetergentType.pod || DetergentType.sheet => amount > 20,
    };
    if (unusual) warnings.add('unusually_large');
  }
}
