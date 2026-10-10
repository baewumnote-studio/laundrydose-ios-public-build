import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/units/unit_preferences.dart';

void main() {
  test('metric and US defaults are deterministic', () {
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.liquid,
        unitSystem: UnitSystemChoice.metric,
        countryCode: 'US',
      ),
      DisplayUnit.ml,
    );
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.liquid,
        unitSystem: UnitSystemChoice.us,
        countryCode: 'KR',
      ),
      DisplayUnit.usFlOz,
    );
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.powder,
        unitSystem: UnitSystemChoice.us,
        countryCode: 'KR',
      ),
      DisplayUnit.ozMass,
    );
  });
  test('auto uses US only for US region', () {
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.liquid,
        unitSystem: UnitSystemChoice.auto,
        countryCode: 'US',
      ),
      DisplayUnit.usFlOz,
    );
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.liquid,
        unitSystem: UnitSystemChoice.auto,
        countryCode: 'KR',
      ),
      DisplayUnit.ml,
    );
    expect(
      preferredDisplayUnitForNewProfile(
        type: DetergentType.powder,
        unitSystem: UnitSystemChoice.auto,
        countryCode: null,
      ),
      DisplayUnit.g,
    );
  });
  test('pod and sheet are region independent', () {
    for (final system in UnitSystemChoice.values) {
      expect(
        preferredDisplayUnitForNewProfile(
          type: DetergentType.pod,
          unitSystem: system,
          countryCode: 'US',
        ),
        DisplayUnit.count,
      );
      expect(
        preferredDisplayUnitForNewProfile(
          type: DetergentType.sheet,
          unitSystem: system,
          countryCode: 'US',
        ),
        DisplayUnit.sheet,
      );
    }
  });
}
