import 'dart:math' as math;
import '../domain/enums.dart';
import '../domain/models.dart';

class DoseCalculator {
  const DoseCalculator();

  DoseCalculation calculate(DetergentBundle bundle, DoseSelection selection) {
    final p = bundle.profile;
    WaterLevel? resolvedWater;
    if (p.waterEnabled) {
      resolvedWater = _resolveWater(bundle, selection.water);
      if (resolvedWater == null) {
        return const DoseCalculation.missing(code: 'water_fallback_missing');
      }
    }

    final result = p.ruleStrategy == RuleStrategy.matrix
        ? _matrix(bundle, selection, resolvedWater)
        : _baseAdjust(bundle, selection, resolvedWater);
    if (!result.isOk) return result;
    final amount = result.amountCanonical!;
    if (!amount.isFinite || amount <= 0) {
      return const DoseCalculation.invalid(code: 'non_positive_result');
    }
    if (p.detergentType == DetergentType.pod &&
        (amount - amount.round()).abs() > 1e-9) {
      return const DoseCalculation.invalid(code: 'fractional_pod');
    }
    if (p.detergentType == DetergentType.sheet &&
        ((amount * 2) - (amount * 2).round()).abs() > 1e-9) {
      return const DoseCalculation.invalid(code: 'sheet_increment');
    }
    return DoseCalculation.ok(amount, resolvedWater: resolvedWater);
  }

  DoseCalculation _matrix(
    DetergentBundle b,
    DoseSelection s,
    WaterLevel? water,
  ) {
    for (final r in b.rules) {
      final loadMatches = b.profile.doseBasis == DoseBasis.standard
          ? r.loadLevel == null
          : r.loadLevel == s.load;
      final soilMatches = !b.profile.soilEnabled
          ? r.soilLevel == null
          : r.soilLevel == s.soil;
      final waterMatches = !b.profile.waterEnabled
          ? r.waterLevel == null
          : r.waterLevel == water;
      if (loadMatches && soilMatches && waterMatches) {
        return DoseCalculation.ok(r.amountCanonical, resolvedWater: water);
      }
    }
    return DoseCalculation.missing(
      code: 'matrix_exact_match_missing',
      resolvedWater: water,
    );
  }

  DoseCalculation _baseAdjust(
    DetergentBundle b,
    DoseSelection s,
    WaterLevel? water,
  ) {
    DoseRuleModel? base;
    for (final r in b.rules) {
      if (r.soilLevel != null || r.waterLevel != null) continue;
      final matches = b.profile.doseBasis == DoseBasis.standard
          ? r.loadLevel == null
          : r.loadLevel == s.load;
      if (matches) {
        base = r;
        break;
      }
    }
    if (base == null) {
      return DoseCalculation.missing(
        code: 'base_missing',
        resolvedWater: water,
      );
    }
    var amount = base.amountCanonical;
    if (b.profile.soilEnabled) {
      final a = _adjustment(b, AdjustmentDimension.soil, s.soil.name);
      if (a == null) {
        return DoseCalculation.missing(
          code: 'soil_adjustment_missing',
          resolvedWater: water,
        );
      }
      amount += a.deltaCanonical;
    }
    if (b.profile.waterEnabled) {
      final a = _adjustment(b, AdjustmentDimension.water, water!.name);
      if (a == null) {
        return DoseCalculation.missing(
          code: 'water_adjustment_missing',
          resolvedWater: water,
        );
      }
      amount += a.deltaCanonical;
    }
    return DoseCalculation.ok(amount, resolvedWater: water);
  }

  DoseAdjustmentModel? _adjustment(
    DetergentBundle b,
    AdjustmentDimension d,
    String key,
  ) {
    for (final a in b.adjustments) {
      if (a.dimension == d && a.optionKey == key) return a;
    }
    return null;
  }

  WaterLevel? _resolveWater(DetergentBundle b, WaterLevel selected) {
    if (selected != WaterLevel.unknown) return selected;
    final raw = b.profile.unknownWaterFallback;
    if (raw == null) return null;
    if (raw == 'medium_if_present') {
      final hasMedium = b.profile.ruleStrategy == RuleStrategy.matrix
          ? b.rules.any((r) => r.waterLevel == WaterLevel.medium)
          : b.adjustments.any(
              (a) =>
                  a.dimension == AdjustmentDimension.water &&
                  a.optionKey == WaterLevel.medium.name,
            );
      return hasMedium ? WaterLevel.medium : null;
    }
    return enumFromDb(WaterLevel.values, raw, fallback: WaterLevel.unknown) ==
            WaterLevel.unknown
        ? null
        : enumFromDb(WaterLevel.values, raw);
  }

  static double? costPerWash(DetergentProfileModel p, double doseCanonical) {
    final qty = p.packageQuantityCanonical;
    final price = p.packagePrice;
    if (qty == null || price == null || qty <= 0 || price < 0) return null;
    return price / qty * doseCanonical;
  }

  static MarkerMatch? markerMatch(
    List<MeasureMarkerModel> markers,
    double amount,
  ) {
    if (markers.isEmpty) return null;
    final sorted = [...markers]
      ..sort((a, b) => a.amountCanonical.compareTo(b.amountCanonical));
    final tolerance = math.max(0.5, amount.abs() * 0.015);
    for (final m in sorted) {
      if ((amount - m.amountCanonical).abs() <= tolerance) {
        return MarkerMatch.near(m.label);
      }
    }
    if (amount < sorted.first.amountCanonical) {
      return MarkerMatch.below(sorted.first.label);
    }
    if (amount > sorted.last.amountCanonical) {
      return MarkerMatch.above(sorted.last.label);
    }
    for (var i = 0; i < sorted.length - 1; i++) {
      if (amount > sorted[i].amountCanonical &&
          amount < sorted[i + 1].amountCanonical) {
        return MarkerMatch.between(sorted[i].label, sorted[i + 1].label);
      }
    }
    return null;
  }
}

enum MarkerMatchType { near, between, below, above }

class MarkerMatch {
  const MarkerMatch._(this.type, this.first, [this.second]);
  factory MarkerMatch.near(String x) => MarkerMatch._(MarkerMatchType.near, x);
  factory MarkerMatch.between(String a, String b) =>
      MarkerMatch._(MarkerMatchType.between, a, b);
  factory MarkerMatch.below(String x) =>
      MarkerMatch._(MarkerMatchType.below, x);
  factory MarkerMatch.above(String x) =>
      MarkerMatch._(MarkerMatchType.above, x);
  final MarkerMatchType type;
  final String first;
  final String? second;
}
