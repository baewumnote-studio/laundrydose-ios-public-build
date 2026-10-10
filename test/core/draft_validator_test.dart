import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/detergent_draft.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/domain/models.dart';
import 'package:laundry_dose/core/validation/draft_validator.dart';

void main() {
  test('pod dose must be whole', () {
    final d = DetergentDraft.newDraft()
      ..name = 'Pods'
      ..setType(DetergentType.pod)
      ..doseBasis = DoseBasis.standard;
    d.baseValues['standard'] = 1.5;
    expect(DraftValidator.validate(d).errors, contains('pods_whole'));
  });
  test('sheet supports half increments', () {
    final d = DetergentDraft.newDraft()
      ..name = 'Sheets'
      ..setType(DetergentType.sheet)
      ..doseBasis = DoseBasis.standard;
    d.baseValues['standard'] = 1.5;
    expect(DraftValidator.validate(d).errors, isEmpty);
  });
  test('matrix requires value or explicit not listed for each cell', () {
    final d = DetergentDraft.newDraft()
      ..name = 'Liquid'
      ..doseBasis = DoseBasis.standard
      ..ruleStrategy = RuleStrategy.matrix
      ..soilEnabled = true;
    final keys = d.requiredMatrixKeys().toList();
    d.matrixValues[keys.first] = 25;
    final r = DraftValidator.validate(d);
    expect(r.errors.any((x) => x.startsWith('matrix_incomplete:')), isTrue);
    for (final k in keys.skip(1)) {
      d.matrixNotListed.add(k);
    }
    expect(DraftValidator.validate(d).isValid, isTrue);
  });
  test('enabled adjustment must be explicitly present including zero', () {
    final d = DetergentDraft.newDraft()
      ..name = 'Liquid'
      ..doseBasis = DoseBasis.standard
      ..soilEnabled = true;
    d.baseValues['standard'] = 35;
    d.soilAdjustments['light'] = 0;
    d.soilAdjustments['normal'] = 5;
    expect(
      DraftValidator.validate(d).errors,
      contains('soil_adjustment_missing:heavy'),
    );
  });

  test('price requires package quantity', () {
    final d = DetergentDraft.newDraft()
      ..name = 'Liquid'
      ..doseBasis = DoseBasis.standard
      ..packagePrice = 5
      ..currencyCode = 'USD';
    d.baseValues['standard'] = 35;
    expect(
      DraftValidator.validate(d).errors,
      contains('package_quantity_required'),
    );
  });
  test('saved matrix reconstructs omitted cells as explicit not listed', () {
    final now = DateTime.utc(2026, 10, 7);
    final b = DetergentBundle(
      profile: DetergentProfileModel(
        id: 'm',
        name: 'M',
        detergentType: DetergentType.liquid,
        ruleStrategy: RuleStrategy.matrix,
        doseBasis: DoseBasis.standard,
        canonicalUnit: CanonicalUnit.ml,
        preferredDisplayUnit: DisplayUnit.ml,
        soilEnabled: true,
        waterEnabled: false,
        machineVariant: MachineVariant.any,
        isDefault: false,
        createdAtUtc: now,
        updatedAtUtc: now,
      ),
      rules: const [
        DoseRuleModel(
          id: 'r',
          detergentId: 'm',
          soilLevel: SoilLevel.normal,
          amountCanonical: 35,
        ),
      ],
      adjustments: const [],
      markers: const [],
    );
    final d = DetergentDraft.fromBundle(b);
    expect(
      d.matrixNotListed,
      containsAll(['standard|light|none', 'standard|heavy|none']),
    );
    expect(DraftValidator.validate(d).isValid, isTrue);
  });
  test('change signature detects edits', () {
    final d = DetergentDraft.newDraft()
      ..name = 'A'
      ..doseBasis = DoseBasis.standard;
    d.baseValues['standard'] = 35;
    final a = d.changeSignature;
    expect(d.changeSignature, a);
    d.brand = 'B';
    expect(d.changeSignature, isNot(a));
  });
}
