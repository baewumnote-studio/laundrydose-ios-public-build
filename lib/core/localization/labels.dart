import 'package:flutter/widgets.dart';
import '../domain/enums.dart';
import 'l10n.dart';

String loadLabel(BuildContext c, LoadLevel v) => switch (v) {
  LoadLevel.small => c.l10n.small,
  LoadLevel.medium => c.l10n.medium,
  LoadLevel.large => c.l10n.large,
  LoadLevel.xl => c.l10n.extraLarge,
};
String soilLabel(BuildContext c, SoilLevel v) => switch (v) {
  SoilLevel.light => c.l10n.light,
  SoilLevel.normal => c.l10n.normal,
  SoilLevel.heavy => c.l10n.heavy,
};
String waterLabel(BuildContext c, WaterLevel v) => switch (v) {
  WaterLevel.soft => c.l10n.soft,
  WaterLevel.medium => c.l10n.medium,
  WaterLevel.hard => c.l10n.hard,
  WaterLevel.unknown => c.l10n.unknown,
};
String detergentTypeLabel(BuildContext c, DetergentType v) => switch (v) {
  DetergentType.liquid => c.l10n.liquid,
  DetergentType.powder => c.l10n.powder,
  DetergentType.pod => c.l10n.pods,
  DetergentType.sheet => c.l10n.sheets,
};
String machineLabel(BuildContext c, MachineVariant v) => switch (v) {
  MachineVariant.any => c.l10n.anyMachine,
  MachineVariant.he => c.l10n.heMachine,
  MachineVariant.standard => c.l10n.standardMachine,
};
String displayUnitLabel(BuildContext c, DisplayUnit v, {double? canonical}) =>
    switch (v) {
      DisplayUnit.ml => c.l10n.unitMl,
      DisplayUnit.usFlOz => c.l10n.unitUsFlOz,
      DisplayUnit.usTbsp => c.l10n.unitTbsp,
      DisplayUnit.usTsp => c.l10n.unitTsp,
      DisplayUnit.g => c.l10n.unitG,
      DisplayUnit.ozMass => c.l10n.unitOz,
      DisplayUnit.count =>
        (canonical ?? 2) == 1 ? c.l10n.unitPod : c.l10n.unitPods,
      DisplayUnit.sheet =>
        (canonical ?? 2) == 1 ? c.l10n.unitSheet : c.l10n.unitSheets,
      DisplayUnit.scoop =>
        (canonical ?? 2) == 1 ? c.l10n.unitScoop : c.l10n.unitScoops,
    };
