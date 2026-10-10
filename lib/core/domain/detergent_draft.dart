import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'enums.dart';
import 'models.dart';

class DraftMarker {
  DraftMarker({
    required this.id,
    required this.label,
    required this.amountCanonical,
  });
  final String id;
  String label;
  double amountCanonical;
}

class DetergentDraft {
  DetergentDraft.newDraft({String? id})
    : id = id ?? const Uuid().v4(),
      createdAtUtc = DateTime.now().toUtc();

  factory DetergentDraft.fromBundle(DetergentBundle bundle) {
    final p = bundle.profile;
    final d = DetergentDraft.newDraft(id: p.id)
      ..name = p.name
      ..brand = p.brand ?? ''
      ..type = p.detergentType
      ..ruleStrategy = p.ruleStrategy
      ..doseBasis = p.doseBasis
      ..canonicalUnit = p.canonicalUnit
      ..preferredDisplayUnit = p.preferredDisplayUnit
      ..soilEnabled = p.soilEnabled
      ..waterEnabled = p.waterEnabled
      ..machineVariant = p.machineVariant
      ..unknownWaterFallback = p.unknownWaterFallback
      ..packageQuantityCanonical = p.packageQuantityCanonical
      ..packagePrice = p.packagePrice
      ..currencyCode = p.currencyCode
      ..photoRelativePath = p.photoRelativePath
      ..originalPhotoRelativePath = p.photoRelativePath
      ..isDefault = p.isDefault
      ..createdAtUtc = p.createdAtUtc;

    for (final rule in bundle.rules) {
      if (p.ruleStrategy == RuleStrategy.matrix) {
        d.matrixValues[matrixKey(
              rule.loadLevel,
              rule.soilLevel,
              rule.waterLevel,
            )] =
            rule.amountCanonical;
      } else {
        d.baseValues[baseKey(rule.loadLevel)] = rule.amountCanonical;
      }
    }
    for (final a in bundle.adjustments) {
      if (a.dimension == AdjustmentDimension.soil) {
        d.soilAdjustments[a.optionKey] = a.deltaCanonical;
      } else {
        d.waterAdjustments[a.optionKey] = a.deltaCanonical;
      }
    }
    if (p.ruleStrategy == RuleStrategy.matrix) {
      for (final key in d.requiredMatrixKeys()) {
        if (!d.matrixValues.containsKey(key)) d.matrixNotListed.add(key);
      }
    }
    d.markers.addAll(
      bundle.markers.map(
        (m) => DraftMarker(
          id: m.id,
          label: m.label,
          amountCanonical: m.amountCanonical,
        ),
      ),
    );
    return d;
  }

  final String id;
  String name = '';
  String brand = '';
  DetergentType type = DetergentType.liquid;
  RuleStrategy ruleStrategy = RuleStrategy.basePlusAdjustments;
  DoseBasis doseBasis = DoseBasis.loadSize;
  CanonicalUnit canonicalUnit = CanonicalUnit.ml;
  DisplayUnit preferredDisplayUnit = DisplayUnit.ml;
  bool soilEnabled = false;
  bool waterEnabled = false;
  MachineVariant machineVariant = MachineVariant.any;
  String? unknownWaterFallback = 'medium_if_present';
  double? packageQuantityCanonical;
  double? packagePrice;
  String? currencyCode;
  String? photoRelativePath;
  String? originalPhotoRelativePath;
  bool isDefault = false;
  DateTime createdAtUtc;

  /// Key is `standard` or a LoadLevel name.
  final Map<String, double> baseValues = {};
  final Map<String, double> soilAdjustments = {};
  final Map<String, double> waterAdjustments = {};
  final Map<String, double> matrixValues = {};
  final Set<String> matrixNotListed = {};
  final List<DraftMarker> markers = [];
  bool includeXl = false;

  bool get isEditing =>
      originalPhotoRelativePath != null ||
      name.isNotEmpty ||
      baseValues.isNotEmpty ||
      matrixValues.isNotEmpty;

  void setType(DetergentType next) {
    type = next;
    if (next == DetergentType.liquid) {
      canonicalUnit = CanonicalUnit.ml;
      preferredDisplayUnit = DisplayUnit.ml;
    } else if (next == DetergentType.powder) {
      canonicalUnit = CanonicalUnit.g;
      preferredDisplayUnit = DisplayUnit.g;
    } else if (next == DetergentType.pod) {
      canonicalUnit = CanonicalUnit.count;
      preferredDisplayUnit = DisplayUnit.count;
    } else {
      canonicalUnit = CanonicalUnit.count;
      preferredDisplayUnit = DisplayUnit.sheet;
    }
    baseValues.clear();
    matrixValues.clear();
    matrixNotListed.clear();
    soilAdjustments.clear();
    waterAdjustments.clear();
    markers.clear();
  }

  Iterable<LoadLevel?> get activeLoads sync* {
    if (doseBasis == DoseBasis.standard) {
      yield null;
      return;
    }
    yield LoadLevel.small;
    yield LoadLevel.medium;
    yield LoadLevel.large;
    if (includeXl ||
        baseValues.containsKey(LoadLevel.xl.name) ||
        matrixValues.keys.any((k) => k.startsWith('${LoadLevel.xl.name}|'))) {
      yield LoadLevel.xl;
    }
  }

  Iterable<SoilLevel?> get activeSoils sync* {
    if (!soilEnabled) {
      yield null;
      return;
    }
    yield* SoilLevel.values;
  }

  Iterable<WaterLevel?> get activeWaters sync* {
    if (!waterEnabled) {
      yield null;
      return;
    }
    yield WaterLevel.soft;
    yield WaterLevel.medium;
    yield WaterLevel.hard;
  }

  Iterable<String> requiredMatrixKeys() sync* {
    for (final load in activeLoads) {
      for (final soil in activeSoils) {
        for (final water in activeWaters) {
          yield matrixKey(load, soil, water);
        }
      }
    }
  }

  String get changeSignature {
    Map<String, double> sorted(Map<String, double> input) {
      final entries = input.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      return {for (final e in entries) e.key: e.value};
    }

    final notListed = matrixNotListed.toList()..sort();
    final markerList = [...markers]..sort((a, b) => a.id.compareTo(b.id));
    return jsonEncode({
      'name': name,
      'brand': brand,
      'type': type.dbName,
      'strategy': ruleStrategy.dbName,
      'basis': doseBasis.dbName,
      'canonical': canonicalUnit.dbName,
      'display': preferredDisplayUnit.dbName,
      'soil': soilEnabled,
      'water': waterEnabled,
      'machine': machineVariant.dbName,
      'fallback': unknownWaterFallback,
      'quantity': packageQuantityCanonical,
      'price': packagePrice,
      'currency': currencyCode,
      'photo': photoRelativePath,
      'default': isDefault,
      'xl': includeXl,
      'base': sorted(baseValues),
      'soilAdj': sorted(soilAdjustments),
      'waterAdj': sorted(waterAdjustments),
      'matrix': sorted(matrixValues),
      'notListed': notListed,
      'markers': [
        for (final m in markerList)
          {'id': m.id, 'label': m.label, 'amount': m.amountCanonical},
      ],
    });
  }

  DetergentBundle toBundle() {
    const uuid = Uuid();
    final now = DateTime.now().toUtc();
    final profile = DetergentProfileModel(
      id: id,
      name: name.trim(),
      brand: brand.trim().isEmpty ? null : brand.trim(),
      detergentType: type,
      ruleStrategy: ruleStrategy,
      doseBasis: doseBasis,
      canonicalUnit: canonicalUnit,
      preferredDisplayUnit: preferredDisplayUnit,
      soilEnabled: soilEnabled,
      waterEnabled: waterEnabled,
      machineVariant: machineVariant,
      unknownWaterFallback: waterEnabled ? unknownWaterFallback : null,
      packageQuantityCanonical: packageQuantityCanonical,
      packagePrice: packagePrice,
      currencyCode: packagePrice == null ? null : currencyCode,
      photoRelativePath: photoRelativePath,
      isDefault: isDefault,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: now,
    );

    final rules = <DoseRuleModel>[];
    final adjustments = <DoseAdjustmentModel>[];
    if (ruleStrategy == RuleStrategy.matrix) {
      for (final key in requiredMatrixKeys()) {
        final amount = matrixValues[key];
        if (amount == null) continue;
        final parts = key.split('|');
        rules.add(
          DoseRuleModel(
            id: uuid.v4(),
            detergentId: id,
            loadLevel: parts[0] == 'standard'
                ? null
                : enumFromDb(LoadLevel.values, parts[0]),
            soilLevel: parts[1] == 'none'
                ? null
                : enumFromDb(SoilLevel.values, parts[1]),
            waterLevel: parts[2] == 'none'
                ? null
                : enumFromDb(WaterLevel.values, parts[2]),
            amountCanonical: amount,
          ),
        );
      }
    } else {
      for (final load in activeLoads) {
        final amount = baseValues[baseKey(load)];
        if (amount == null) continue;
        rules.add(
          DoseRuleModel(
            id: uuid.v4(),
            detergentId: id,
            loadLevel: load,
            amountCanonical: amount,
          ),
        );
      }
      if (soilEnabled) {
        for (final value in SoilLevel.values) {
          final delta = soilAdjustments[value.name];
          if (delta == null) continue;
          adjustments.add(
            DoseAdjustmentModel(
              id: uuid.v4(),
              detergentId: id,
              dimension: AdjustmentDimension.soil,
              optionKey: value.name,
              deltaCanonical: delta,
            ),
          );
        }
      }
      if (waterEnabled) {
        for (final value in [
          WaterLevel.soft,
          WaterLevel.medium,
          WaterLevel.hard,
        ]) {
          final delta = waterAdjustments[value.name];
          if (delta == null) continue;
          adjustments.add(
            DoseAdjustmentModel(
              id: uuid.v4(),
              detergentId: id,
              dimension: AdjustmentDimension.water,
              optionKey: value.name,
              deltaCanonical: delta,
            ),
          );
        }
      }
    }

    final markerModels = [...markers]
      ..sort((a, b) => a.amountCanonical.compareTo(b.amountCanonical));
    return DetergentBundle(
      profile: profile,
      rules: rules,
      adjustments: adjustments,
      markers: [
        for (var i = 0; i < markerModels.length; i++)
          MeasureMarkerModel(
            id: markerModels[i].id,
            detergentId: id,
            label: markerModels[i].label.trim(),
            amountCanonical: markerModels[i].amountCanonical,
            sortOrder: i,
          ),
      ],
    );
  }

  static String baseKey(LoadLevel? load) => load?.name ?? 'standard';
  static String matrixKey(
    LoadLevel? load,
    SoilLevel? soil,
    WaterLevel? water,
  ) =>
      '${load?.name ?? 'standard'}|${soil?.name ?? 'none'}|${water?.name ?? 'none'}';
}
