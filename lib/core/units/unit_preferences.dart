import '../domain/enums.dart';

DisplayUnit preferredDisplayUnitForNewProfile({
  required DetergentType type,
  required UnitSystemChoice unitSystem,
  required String? countryCode,
}) {
  final resolved = unitSystem == UnitSystemChoice.auto
      ? (countryCode?.toUpperCase() == 'US'
            ? UnitSystemChoice.us
            : UnitSystemChoice.metric)
      : unitSystem;
  return switch (type) {
    DetergentType.liquid =>
      resolved == UnitSystemChoice.us ? DisplayUnit.usFlOz : DisplayUnit.ml,
    DetergentType.powder =>
      resolved == UnitSystemChoice.us ? DisplayUnit.ozMass : DisplayUnit.g,
    DetergentType.pod => DisplayUnit.count,
    DetergentType.sheet => DisplayUnit.sheet,
  };
}
