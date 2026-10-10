import 'enums.dart';

class DetergentProfileModel {
  const DetergentProfileModel({
    required this.id,
    required this.name,
    this.brand,
    required this.detergentType,
    required this.ruleStrategy,
    required this.doseBasis,
    required this.canonicalUnit,
    required this.preferredDisplayUnit,
    required this.soilEnabled,
    required this.waterEnabled,
    required this.machineVariant,
    this.unknownWaterFallback,
    this.packageQuantityCanonical,
    this.packagePrice,
    this.currencyCode,
    this.photoRelativePath,
    required this.isDefault,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });

  final String id;
  final String name;
  final String? brand;
  final DetergentType detergentType;
  final RuleStrategy ruleStrategy;
  final DoseBasis doseBasis;
  final CanonicalUnit canonicalUnit;
  final DisplayUnit preferredDisplayUnit;
  final bool soilEnabled;
  final bool waterEnabled;
  final MachineVariant machineVariant;
  final String? unknownWaterFallback; // soft|medium|hard|medium_if_present|null
  final double? packageQuantityCanonical;
  final double? packagePrice;
  final String? currencyCode;
  final String? photoRelativePath;
  final bool isDefault;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
}

class DoseRuleModel {
  const DoseRuleModel({
    required this.id,
    required this.detergentId,
    this.loadLevel,
    this.soilLevel,
    this.waterLevel,
    required this.amountCanonical,
  });
  final String id;
  final String detergentId;
  final LoadLevel? loadLevel;
  final SoilLevel? soilLevel;
  final WaterLevel? waterLevel;
  final double amountCanonical;
}

class DoseAdjustmentModel {
  const DoseAdjustmentModel({
    required this.id,
    required this.detergentId,
    required this.dimension,
    required this.optionKey,
    required this.deltaCanonical,
  });
  final String id;
  final String detergentId;
  final AdjustmentDimension dimension;
  final String optionKey;
  final double deltaCanonical;
}

class MeasureMarkerModel {
  const MeasureMarkerModel({
    required this.id,
    required this.detergentId,
    required this.label,
    required this.amountCanonical,
    required this.sortOrder,
  });
  final String id;
  final String detergentId;
  final String label;
  final double amountCanonical;
  final int sortOrder;
}

class DetergentBundle {
  const DetergentBundle({
    required this.profile,
    required this.rules,
    required this.adjustments,
    required this.markers,
  });
  final DetergentProfileModel profile;
  final List<DoseRuleModel> rules;
  final List<DoseAdjustmentModel> adjustments;
  final List<MeasureMarkerModel> markers;
}

class DoseSelection {
  const DoseSelection({
    this.load = LoadLevel.medium,
    this.soil = SoilLevel.normal,
    this.water = WaterLevel.unknown,
  });
  final LoadLevel load;
  final SoilLevel soil;
  final WaterLevel water;
  DoseSelection copyWith({
    LoadLevel? load,
    SoilLevel? soil,
    WaterLevel? water,
  }) => DoseSelection(
    load: load ?? this.load,
    soil: soil ?? this.soil,
    water: water ?? this.water,
  );
}

class DoseCalculation {
  const DoseCalculation._({
    required this.status,
    this.amountCanonical,
    this.resolvedWater,
    this.messageCode,
  });
  const DoseCalculation.ok(double amount, {WaterLevel? resolvedWater})
    : this._(
        status: DoseStatus.ok,
        amountCanonical: amount,
        resolvedWater: resolvedWater,
      );
  const DoseCalculation.missing({String? code, WaterLevel? resolvedWater})
    : this._(
        status: DoseStatus.missingRule,
        messageCode: code,
        resolvedWater: resolvedWater,
      );
  const DoseCalculation.invalid({String? code})
    : this._(status: DoseStatus.invalidProfile, messageCode: code);
  final DoseStatus status;
  final double? amountCanonical;
  final WaterLevel? resolvedWater;
  final String? messageCode;
  bool get isOk => status == DoseStatus.ok && amountCanonical != null;
}

class WashLogModel {
  const WashLogModel({
    required this.id,
    this.detergentId,
    required this.detergentNameSnapshot,
    required this.detergentTypeSnapshot,
    required this.amountCanonical,
    required this.canonicalUnit,
    required this.displayAmountSnapshot,
    required this.displayUnitSnapshot,
    this.loadLevel,
    this.soilLevel,
    this.waterLevel,
    this.costMinorUnits,
    this.currencyCode,
    required this.loggedAtUtc,
  });
  final String id;
  final String? detergentId;
  final String detergentNameSnapshot;
  final DetergentType detergentTypeSnapshot;
  final double amountCanonical;
  final CanonicalUnit canonicalUnit;
  final String displayAmountSnapshot;
  final String displayUnitSnapshot;
  final LoadLevel? loadLevel;
  final SoilLevel? soilLevel;
  final WaterLevel? waterLevel;
  final int? costMinorUnits;
  final String? currencyCode;
  final DateTime loggedAtUtc;
}

class AppSettingsModel {
  const AppSettingsModel({
    required this.onboardingCompleted,
    required this.themeMode,
    this.localeOverride,
    required this.unitSystem,
    required this.defaultLoadLevel,
    required this.defaultSoilLevel,
    required this.defaultWaterLevel,
    this.selectedDetergentId,
    required this.reducedMotionOverride,
  });
  final bool onboardingCompleted;
  final ThemeChoice themeMode;
  final String? localeOverride;
  final UnitSystemChoice unitSystem;
  final LoadLevel defaultLoadLevel;
  final SoilLevel defaultSoilLevel;
  final WaterLevel defaultWaterLevel;
  final String? selectedDetergentId;
  final ReducedMotionChoice reducedMotionOverride;
}

class AdStateModel {
  const AdStateModel({
    required this.lifetimeSuccessfulLogs,
    this.lastInterstitialAtUtc,
    required this.adsShownToday,
    this.adsShownDateLocal,
    required this.firstSessionCompleted,
    this.lastEligibilityConsumedLogId,
  });
  final int lifetimeSuccessfulLogs;
  final DateTime? lastInterstitialAtUtc;
  final int adsShownToday;
  final String? adsShownDateLocal;
  final bool firstSessionCompleted;
  final String? lastEligibilityConsumedLogId;
}
