import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/units/unit_converter.dart';

void main() {
  test('US liquid constants are exact contract constants', () {
    expect(UnitConverter.toCanonical(1, DisplayUnit.usFlOz), 29.5735295625);
    expect(UnitConverter.toCanonical(1, DisplayUnit.usTbsp), 14.78676478125);
    expect(UnitConverter.toCanonical(1, DisplayUnit.usTsp), 4.92892159375);
  });
  test(
    'mass ounce converts to grams',
    () =>
        expect(UnitConverter.toCanonical(1, DisplayUnit.ozMass), 28.349523125),
  );
  test('round trip preserves value', () {
    for (final u in [
      DisplayUnit.ml,
      DisplayUnit.usFlOz,
      DisplayUnit.usTbsp,
      DisplayUnit.usTsp,
      DisplayUnit.g,
      DisplayUnit.ozMass,
      DisplayUnit.count,
      DisplayUnit.sheet,
      DisplayUnit.scoop,
    ]) {
      final c = UnitConverter.toCanonical(7.25, u);
      expect(UnitConverter.fromCanonical(c, u), closeTo(7.25, 1e-10));
    }
  });
}
