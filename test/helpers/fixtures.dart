import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/domain/models.dart';

DetergentBundle liquidBundle({
  RuleStrategy strategy = RuleStrategy.basePlusAdjustments,
  bool soil = false,
  bool water = false,
  String? waterFallback,
  List<DoseRuleModel>? rules,
  List<DoseAdjustmentModel>? adjustments,
  List<MeasureMarkerModel>? markers,
}) {
  final now = DateTime.utc(2026, 10, 7);
  return DetergentBundle(
    profile: DetergentProfileModel(
      id: 'd1',
      name: 'Test',
      detergentType: DetergentType.liquid,
      ruleStrategy: strategy,
      doseBasis: DoseBasis.loadSize,
      canonicalUnit: CanonicalUnit.ml,
      preferredDisplayUnit: DisplayUnit.ml,
      soilEnabled: soil,
      waterEnabled: water,
      machineVariant: MachineVariant.any,
      unknownWaterFallback: waterFallback,
      isDefault: true,
      createdAtUtc: now,
      updatedAtUtc: now,
    ),
    rules:
        rules ??
        const [
          DoseRuleModel(
            id: 'r1',
            detergentId: 'd1',
            loadLevel: LoadLevel.medium,
            amountCanonical: 35,
          ),
        ],
    adjustments: adjustments ?? const [],
    markers: markers ?? const [],
  );
}
