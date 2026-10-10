import 'package:intl/intl.dart';
import '../domain/enums.dart';
import '../units/unit_converter.dart';

class LocaleNumberParser {
  static double? parse(String input, String locale) {
    var raw = input.trim().replaceAll('\u00A0', '').replaceAll(' ', '');
    if (raw.isEmpty) return null;
    try {
      final symbols = NumberFormat.decimalPattern(locale).symbols;
      final group = symbols.GROUP_SEP;
      final decimal = symbols.DECIMAL_SEP;
      if (group.isNotEmpty) raw = raw.replaceAll(group, '');
      if (decimal != '.') raw = raw.replaceAll(decimal, '.');
      // Be forgiving when a hardware keyboard uses the other common separator.
      if (raw.contains(',') && !raw.contains('.')) {
        raw = raw.replaceAll(',', '.');
      }
      return double.tryParse(raw);
    } catch (_) {
      return double.tryParse(raw.replaceAll(',', '.'));
    }
  }
}

class DoseFormatter {
  static String numeric(double canonical, DisplayUnit unit, String locale) {
    final v = UnitConverter.fromCanonical(canonical, unit);
    final digits = switch (unit) {
      DisplayUnit.ml || DisplayUnit.g => v.abs() >= 10 ? 0 : 1,
      DisplayUnit.usFlOz || DisplayUnit.ozMass => _isWhole(v) ? 0 : 2,
      DisplayUnit.usTbsp || DisplayUnit.usTsp => _isWhole(v) ? 0 : 1,
      DisplayUnit.count => 0,
      DisplayUnit.sheet || DisplayUnit.scoop => _isWhole(v) ? 0 : 1,
    };
    final rounded = switch (unit) {
      DisplayUnit.ml ||
      DisplayUnit.g => v.abs() >= 10 ? v.roundToDouble() : (v * 2).round() / 2,
      _ => v,
    };
    return NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: digits,
    ).format(rounded);
  }

  static String unitLabel(DisplayUnit unit, double canonical) => switch (unit) {
    DisplayUnit.ml => 'mL',
    DisplayUnit.usFlOz => 'US fl oz',
    DisplayUnit.usTbsp => 'tbsp',
    DisplayUnit.usTsp => 'tsp',
    DisplayUnit.g => 'g',
    DisplayUnit.ozMass => 'oz (weight)',
    DisplayUnit.count => canonical == 1 ? 'pod' : 'pods',
    DisplayUnit.sheet => canonical == 1 ? 'sheet' : 'sheets',
    DisplayUnit.scoop => canonical == 1 ? 'scoop' : 'scoops',
  };

  static int costMinorUnits(double raw, String currency) {
    final digits =
        NumberFormat.simpleCurrency(name: currency).decimalDigits ?? 2;
    final factor = _pow10(digits);
    return (raw * factor).round();
  }

  static String formatCost(double raw, String currency, String locale) =>
      NumberFormat.simpleCurrency(name: currency, locale: locale).format(raw);

  static bool _isWhole(double v) => (v - v.round()).abs() < 1e-9;
  static int _pow10(int n) {
    var out = 1;
    for (var i = 0; i < n; i++) {
      out *= 10;
    }
    return out;
  }
}
