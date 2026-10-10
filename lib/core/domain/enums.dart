enum DetergentType { liquid, powder, pod, sheet }

enum RuleStrategy { basePlusAdjustments, matrix }

enum DoseBasis { standard, loadSize }

enum CanonicalUnit { ml, g, count, scoop }

enum DisplayUnit { ml, usFlOz, usTbsp, usTsp, g, ozMass, count, sheet, scoop }

enum LoadLevel { small, medium, large, xl }

enum SoilLevel { light, normal, heavy }

enum WaterLevel { soft, medium, hard, unknown }

enum MachineVariant { any, he, standard }

enum AdjustmentDimension { soil, water }

enum ThemeChoice { system, light, dark }

enum UnitSystemChoice { auto, metric, us }

enum ReducedMotionChoice { system, reduce, allow }

enum DoseStatus { ok, missingRule, invalidProfile }

enum AdjustmentDirection { increase, decrease, noChange }

extension EnumDbName on Enum {
  String get dbName {
    if (this is RuleStrategy) {
      return this == RuleStrategy.basePlusAdjustments
          ? 'base_plus_adjustments'
          : 'matrix';
    }
    if (this is DoseBasis) {
      return this == DoseBasis.loadSize ? 'load_size' : 'standard';
    }
    if (this is CanonicalUnit) return name;
    if (this is DisplayUnit) {
      return switch (this as DisplayUnit) {
        DisplayUnit.usFlOz => 'us_fl_oz',
        DisplayUnit.usTbsp => 'us_tbsp',
        DisplayUnit.usTsp => 'us_tsp',
        DisplayUnit.ozMass => 'oz_mass',
        _ => name,
      };
    }
    return name;
  }
}

T enumFromDb<T extends Enum>(Iterable<T> values, String raw, {T? fallback}) {
  for (final value in values) {
    if (value.dbName == raw || value.name == raw) return value;
  }
  if (fallback != null) return fallback;
  throw ArgumentError.value(raw, 'raw', 'Unsupported enum value for $T');
}
