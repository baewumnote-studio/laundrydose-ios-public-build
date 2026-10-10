import '../domain/enums.dart';

class UnitConverter {
  static const usFlOzMl = 29.5735295625;
  static const usTbspMl = 14.78676478125;
  static const usTspMl = 4.92892159375;
  static const ozMassG = 28.349523125;

  static double toCanonical(double value, DisplayUnit unit) => switch (unit) {
    DisplayUnit.ml => value,
    DisplayUnit.usFlOz => value * usFlOzMl,
    DisplayUnit.usTbsp => value * usTbspMl,
    DisplayUnit.usTsp => value * usTspMl,
    DisplayUnit.g => value,
    DisplayUnit.ozMass => value * ozMassG,
    DisplayUnit.count || DisplayUnit.sheet || DisplayUnit.scoop => value,
  };

  static double fromCanonical(double value, DisplayUnit unit) => switch (unit) {
    DisplayUnit.ml => value,
    DisplayUnit.usFlOz => value / usFlOzMl,
    DisplayUnit.usTbsp => value / usTbspMl,
    DisplayUnit.usTsp => value / usTspMl,
    DisplayUnit.g => value,
    DisplayUnit.ozMass => value / ozMassG,
    DisplayUnit.count || DisplayUnit.sheet || DisplayUnit.scoop => value,
  };

  static List<DisplayUnit> validDisplayUnits(
    DetergentType type,
    CanonicalUnit canonical,
  ) => switch (type) {
    DetergentType.liquid => const [
      DisplayUnit.ml,
      DisplayUnit.usFlOz,
      DisplayUnit.usTbsp,
      DisplayUnit.usTsp,
    ],
    DetergentType.powder =>
      canonical == CanonicalUnit.scoop
          ? const [DisplayUnit.scoop]
          : const [DisplayUnit.g, DisplayUnit.ozMass],
    DetergentType.pod => const [DisplayUnit.count],
    DetergentType.sheet => const [DisplayUnit.sheet],
  };
}
