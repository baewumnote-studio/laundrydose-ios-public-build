import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/formatters/number_formatters.dart';
import 'package:laundry_dose/core/units/unit_converter.dart';

void main() {
  test('locale decimal parser accepts comma and dot', () {
    expect(LocaleNumberParser.parse('12,5', 'de-DE'), 12.5);
    expect(LocaleNumberParser.parse('12.5', 'en-US'), 12.5);
  });
  test('display rounding contract', () {
    expect(DoseFormatter.numeric(9.74, DisplayUnit.ml, 'en-US'), '9.5');
    expect(DoseFormatter.numeric(10.49, DisplayUnit.ml, 'en-US'), '10');
  });
  test('minor units honor currency digits', () {
    expect(DoseFormatter.costMinorUnits(0.3307169, 'USD'), 33);
    expect(DoseFormatter.costMinorUnits(123.6, 'JPY'), 124);
  });
  test(
    'US measures retain useful fractions without trailing decimal zeros',
    () {
      expect(
        DoseFormatter.numeric(
          2 * UnitConverter.usTbspMl,
          DisplayUnit.usTbsp,
          'en-US',
        ),
        '2',
      );
      expect(
        DoseFormatter.numeric(
          1.5 * UnitConverter.usTbspMl,
          DisplayUnit.usTbsp,
          'en-US',
        ),
        '1.5',
      );
      expect(
        DoseFormatter.numeric(
          .75 * UnitConverter.usFlOzMl,
          DisplayUnit.usFlOz,
          'en-US',
        ),
        '0.75',
      );
    },
  );
}
