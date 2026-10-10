import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/calculation/dose_calculator.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/domain/models.dart';
import '../helpers/fixtures.dart';

void main() {
  const calc = DoseCalculator();
  test('liquid base lookup returns exact saved value', () {
    final r = calc.calculate(
      liquidBundle(),
      const DoseSelection(load: LoadLevel.medium),
    );
    expect(r.isOk, isTrue);
    expect(r.amountCanonical, 35);
  });
  test('base plus soil and water additions', () {
    final b = liquidBundle(
      soil: true,
      water: true,
      waterFallback: 'medium',
      adjustments: const [
        DoseAdjustmentModel(
          id: 'a1',
          detergentId: 'd1',
          dimension: AdjustmentDimension.soil,
          optionKey: 'normal',
          deltaCanonical: 5,
        ),
        DoseAdjustmentModel(
          id: 'a2',
          detergentId: 'd1',
          dimension: AdjustmentDimension.water,
          optionKey: 'medium',
          deltaCanonical: 10,
        ),
      ],
    );
    final r = calc.calculate(
      b,
      const DoseSelection(
        load: LoadLevel.medium,
        soil: SoilLevel.normal,
        water: WaterLevel.unknown,
      ),
    );
    expect(r.amountCanonical, 50);
    expect(r.resolvedWater, WaterLevel.medium);
  });
  test('missing enabled adjustment never guesses', () {
    final b = liquidBundle(soil: true);
    final r = calc.calculate(
      b,
      const DoseSelection(load: LoadLevel.medium, soil: SoilLevel.heavy),
    );
    expect(r.status, DoseStatus.missingRule);
  });
  test('matrix exact match and missing cell', () {
    final b = liquidBundle(
      strategy: RuleStrategy.matrix,
      soil: true,
      rules: const [
        DoseRuleModel(
          id: 'x',
          detergentId: 'd1',
          loadLevel: LoadLevel.large,
          soilLevel: SoilLevel.heavy,
          amountCanonical: 70,
        ),
      ],
    );
    expect(
      calc
          .calculate(
            b,
            const DoseSelection(load: LoadLevel.large, soil: SoilLevel.heavy),
          )
          .amountCanonical,
      70,
    );
    expect(
      calc
          .calculate(
            b,
            const DoseSelection(load: LoadLevel.small, soil: SoilLevel.heavy),
          )
          .status,
      DoseStatus.missingRule,
    );
  });
  test('marker match exact/between/below/above', () {
    const markers = [
      MeasureMarkerModel(
        id: '1',
        detergentId: 'd1',
        label: 'Line 1',
        amountCanonical: 25,
        sortOrder: 0,
      ),
      MeasureMarkerModel(
        id: '2',
        detergentId: 'd1',
        label: 'Line 2',
        amountCanonical: 40,
        sortOrder: 1,
      ),
    ];
    expect(DoseCalculator.markerMatch(markers, 25)!.type, MarkerMatchType.near);
    expect(
      DoseCalculator.markerMatch(markers, 32)!.type,
      MarkerMatchType.between,
    );
    expect(DoseCalculator.markerMatch(markers, 5)!.type, MarkerMatchType.below);
    expect(
      DoseCalculator.markerMatch(markers, 70)!.type,
      MarkerMatchType.above,
    );
  });
  test('cost per wash uses canonical quantity', () {
    final p = liquidBundle().profile;
    final priced = DetergentProfileModel(
      id: p.id,
      name: p.name,
      detergentType: p.detergentType,
      ruleStrategy: p.ruleStrategy,
      doseBasis: p.doseBasis,
      canonicalUnit: p.canonicalUnit,
      preferredDisplayUnit: p.preferredDisplayUnit,
      soilEnabled: p.soilEnabled,
      waterEnabled: p.waterEnabled,
      machineVariant: p.machineVariant,
      packageQuantityCanonical: 2720,
      packagePrice: 19.99,
      currencyCode: 'USD',
      isDefault: true,
      createdAtUtc: p.createdAtUtc,
      updatedAtUtc: p.updatedAtUtc,
    );
    expect(
      DoseCalculator.costPerWash(priced, 45)!,
      closeTo(0.3307169, 0.00001),
    );
  });

  test('corrupt fractional pod is rejected by engine', () {
    final b = liquidBundle();
    final p = b.profile;
    final pod = DetergentBundle(
      profile: DetergentProfileModel(
        id: 'pod',
        name: 'Pod',
        detergentType: DetergentType.pod,
        ruleStrategy: RuleStrategy.basePlusAdjustments,
        doseBasis: DoseBasis.standard,
        canonicalUnit: CanonicalUnit.count,
        preferredDisplayUnit: DisplayUnit.count,
        soilEnabled: false,
        waterEnabled: false,
        machineVariant: MachineVariant.any,
        isDefault: false,
        createdAtUtc: p.createdAtUtc,
        updatedAtUtc: p.updatedAtUtc,
      ),
      rules: const [
        DoseRuleModel(id: 'r', detergentId: 'pod', amountCanonical: 1.5),
      ],
      adjustments: const [],
      markers: const [],
    );
    expect(
      calc.calculate(pod, const DoseSelection()).status,
      DoseStatus.invalidProfile,
    );
  });
  test('sheet accepts half but rejects quarter count', () {
    final b = liquidBundle();
    final p = b.profile;
    DetergentBundle sheet(double a) => DetergentBundle(
      profile: DetergentProfileModel(
        id: 'sheet',
        name: 'Sheet',
        detergentType: DetergentType.sheet,
        ruleStrategy: RuleStrategy.basePlusAdjustments,
        doseBasis: DoseBasis.standard,
        canonicalUnit: CanonicalUnit.count,
        preferredDisplayUnit: DisplayUnit.sheet,
        soilEnabled: false,
        waterEnabled: false,
        machineVariant: MachineVariant.any,
        isDefault: false,
        createdAtUtc: p.createdAtUtc,
        updatedAtUtc: p.updatedAtUtc,
      ),
      rules: [DoseRuleModel(id: 'r', detergentId: 'sheet', amountCanonical: a)],
      adjustments: const [],
      markers: const [],
    );
    expect(calc.calculate(sheet(1.5), const DoseSelection()).isOk, isTrue);
    expect(
      calc.calculate(sheet(1.25), const DoseSelection()).status,
      DoseStatus.invalidProfile,
    );
  });
}
