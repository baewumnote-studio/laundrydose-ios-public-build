import '../domain/enums.dart';

class Validators {
  static String? requiredName(String? value) {
    final t = value?.trim() ?? '';
    if (t.isEmpty) return 'validationRequired';
    if (t.runes.length > 60) return 'validationNameTooLong';
    return null;
  }

  static String? positive(double? v) =>
      v == null || !v.isFinite || v <= 0 ? 'validationPositive' : null;
  static String? nonNegative(double? v) =>
      v == null || !v.isFinite || v < 0 ? 'validationNonNegative' : null;
  static String? discreteDose(DetergentType type, double? v) {
    final p = positive(v);
    if (p != null) return p;
    if (type == DetergentType.pod && (v! - v.round()).abs() > 1e-9) {
      return 'validationWholePods';
    }
    if (type == DetergentType.sheet &&
        ((v! * 2) - (v * 2).round()).abs() > 1e-9) {
      return 'validationHalfSheets';
    }
    return null;
  }

  static bool unusuallyLarge(DetergentType type, double v) => switch (type) {
    DetergentType.pod || DetergentType.sheet => v > 20,
    DetergentType.liquid => v > 500,
    DetergentType.powder => v > 1000,
  };
}
