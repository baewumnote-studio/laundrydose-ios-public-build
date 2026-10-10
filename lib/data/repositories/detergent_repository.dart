import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../core/domain/enums.dart';
import '../../core/domain/models.dart';
import '../db/app_database.dart';

class DetergentRepository {
  DetergentRepository(this.db);
  final AppDatabase db;

  Stream<List<DetergentProfileModel>> watchProfiles() =>
      (db.select(db.detergentProfiles)..orderBy([
            (t) => OrderingTerm.desc(t.isDefault),
            (t) => OrderingTerm.asc(t.name),
          ]))
          .watch()
          .map((rows) => rows.map(_profile).toList());

  Stream<DetergentBundle?> watchBundle(String id) =>
      (db.select(db.detergentProfiles)..where((t) => t.id.equals(id)))
          .watchSingleOrNull()
          .asyncMap((row) async {
            if (row == null) return null;
            return _bundleFromRow(row);
          });

  Future<DetergentBundle?> getBundle(String id) async {
    final row = await (db.select(
      db.detergentProfiles,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _bundleFromRow(row);
  }

  Future<DetergentBundle> _bundleFromRow(DetergentProfile row) async {
    final rules = await (db.select(
      db.doseRules,
    )..where((t) => t.detergentId.equals(row.id))).get();
    final adj = await (db.select(
      db.doseAdjustments,
    )..where((t) => t.detergentId.equals(row.id))).get();
    final markers =
        await (db.select(db.measureMarkers)
              ..where((t) => t.detergentId.equals(row.id))
              ..orderBy([(t) => OrderingTerm.asc(t.amountCanonical)]))
            .get();
    return DetergentBundle(
      profile: _profile(row),
      rules: rules
          .map(
            (r) => DoseRuleModel(
              id: r.id,
              detergentId: r.detergentId,
              loadLevel: r.loadLevel == null
                  ? null
                  : enumFromDb(LoadLevel.values, r.loadLevel!),
              soilLevel: r.soilLevel == null
                  ? null
                  : enumFromDb(SoilLevel.values, r.soilLevel!),
              waterLevel: r.waterLevel == null
                  ? null
                  : enumFromDb(WaterLevel.values, r.waterLevel!),
              amountCanonical: r.amountCanonical,
            ),
          )
          .toList(),
      adjustments: adj
          .map(
            (a) => DoseAdjustmentModel(
              id: a.id,
              detergentId: a.detergentId,
              dimension: enumFromDb(AdjustmentDimension.values, a.dimension),
              optionKey: a.optionKey,
              deltaCanonical: a.deltaCanonical,
            ),
          )
          .toList(),
      markers: markers
          .map(
            (m) => MeasureMarkerModel(
              id: m.id,
              detergentId: m.detergentId,
              label: m.label,
              amountCanonical: m.amountCanonical,
              sortOrder: m.sortOrder,
            ),
          )
          .toList(),
    );
  }

  Future<void> saveBundle(DetergentBundle bundle) async {
    final p = bundle.profile;
    await db.transaction(() async {
      await db
          .into(db.detergentProfiles)
          .insertOnConflictUpdate(
            DetergentProfilesCompanion(
              id: Value(p.id),
              name: Value(p.name.trim()),
              brand: Value(
                p.brand?.trim().isEmpty == true ? null : p.brand?.trim(),
              ),
              detergentType: Value(p.detergentType.dbName),
              ruleStrategy: Value(p.ruleStrategy.dbName),
              doseBasis: Value(p.doseBasis.dbName),
              canonicalUnit: Value(p.canonicalUnit.dbName),
              preferredDisplayUnit: Value(p.preferredDisplayUnit.dbName),
              soilEnabled: Value(p.soilEnabled),
              waterEnabled: Value(p.waterEnabled),
              machineVariant: Value(p.machineVariant.dbName),
              unknownWaterFallback: Value(p.unknownWaterFallback),
              packageQuantityCanonical: Value(p.packageQuantityCanonical),
              packagePrice: Value(p.packagePrice),
              currencyCode: Value(p.currencyCode),
              photoRelativePath: Value(p.photoRelativePath),
              isDefault: Value(p.isDefault),
              createdAtUtc: Value(p.createdAtUtc),
              updatedAtUtc: Value(DateTime.now().toUtc()),
            ),
          );
      await (db.delete(
        db.doseRules,
      )..where((t) => t.detergentId.equals(p.id))).go();
      await (db.delete(
        db.doseAdjustments,
      )..where((t) => t.detergentId.equals(p.id))).go();
      await (db.delete(
        db.measureMarkers,
      )..where((t) => t.detergentId.equals(p.id))).go();
      for (final r in bundle.rules) {
        await db
            .into(db.doseRules)
            .insert(
              DoseRulesCompanion.insert(
                id: r.id,
                detergentId: r.detergentId,
                loadLevel: Value(r.loadLevel?.dbName),
                soilLevel: Value(r.soilLevel?.dbName),
                waterLevel: Value(r.waterLevel?.dbName),
                amountCanonical: r.amountCanonical,
                createdAtUtc: DateTime.now().toUtc(),
              ),
            );
      }
      for (final a in bundle.adjustments) {
        await db
            .into(db.doseAdjustments)
            .insert(
              DoseAdjustmentsCompanion.insert(
                id: a.id,
                detergentId: a.detergentId,
                dimension: a.dimension.dbName,
                optionKey: a.optionKey,
                deltaCanonical: Value(a.deltaCanonical),
              ),
            );
      }
      for (final m in bundle.markers) {
        await db
            .into(db.measureMarkers)
            .insert(
              MeasureMarkersCompanion.insert(
                id: m.id,
                detergentId: m.detergentId,
                label: m.label,
                amountCanonical: m.amountCanonical,
                sortOrder: Value(m.sortOrder),
              ),
            );
      }
    });
  }

  Future<List<DetergentProfileModel>> getProfiles() async {
    final rows =
        await (db.select(db.detergentProfiles)..orderBy([
              (t) => OrderingTerm.desc(t.isDefault),
              (t) => OrderingTerm.asc(t.name),
            ]))
            .get();
    return rows.map(_profile).toList();
  }

  Future<void> ensureDefaultAndSelect(String id) async {
    final anyDefault = await (db.select(
      db.detergentProfiles,
    )..where((t) => t.isDefault.equals(true))).getSingleOrNull();
    if (anyDefault == null) await setDefault(id);
    await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
      AppSettingsCompanion(selectedDetergentId: Value(id)),
    );
  }

  Future<void> duplicateProfile(
    String sourceId, {
    required String newId,
    required String newName,
    String? newPhotoRelativePath,
  }) async {
    final source = await getBundle(sourceId);
    if (source == null) throw StateError('Source detergent not found');
    const uuid = Uuid();
    final now = DateTime.now().toUtc();
    final p = source.profile;
    final copy = DetergentBundle(
      profile: DetergentProfileModel(
        id: newId,
        name: newName,
        brand: p.brand,
        detergentType: p.detergentType,
        ruleStrategy: p.ruleStrategy,
        doseBasis: p.doseBasis,
        canonicalUnit: p.canonicalUnit,
        preferredDisplayUnit: p.preferredDisplayUnit,
        soilEnabled: p.soilEnabled,
        waterEnabled: p.waterEnabled,
        machineVariant: p.machineVariant,
        unknownWaterFallback: p.unknownWaterFallback,
        packageQuantityCanonical: p.packageQuantityCanonical,
        packagePrice: p.packagePrice,
        currencyCode: p.currencyCode,
        photoRelativePath: newPhotoRelativePath,
        isDefault: false,
        createdAtUtc: now,
        updatedAtUtc: now,
      ),
      rules: source.rules
          .map(
            (r) => DoseRuleModel(
              id: uuid.v4(),
              detergentId: newId,
              loadLevel: r.loadLevel,
              soilLevel: r.soilLevel,
              waterLevel: r.waterLevel,
              amountCanonical: r.amountCanonical,
            ),
          )
          .toList(),
      adjustments: source.adjustments
          .map(
            (a) => DoseAdjustmentModel(
              id: uuid.v4(),
              detergentId: newId,
              dimension: a.dimension,
              optionKey: a.optionKey,
              deltaCanonical: a.deltaCanonical,
            ),
          )
          .toList(),
      markers: source.markers
          .map(
            (m) => MeasureMarkerModel(
              id: uuid.v4(),
              detergentId: newId,
              label: m.label,
              amountCanonical: m.amountCanonical,
              sortOrder: m.sortOrder,
            ),
          )
          .toList(),
    );
    await saveBundle(copy);
  }

  Future<void> deleteProfile(String id) async => db.transaction(() async {
    await (db.delete(db.detergentProfiles)..where((t) => t.id.equals(id))).go();
    final remaining = await (db.select(
      db.detergentProfiles,
    )..orderBy([(t) => OrderingTerm.asc(t.createdAtUtc)])).get();
    if (remaining.isEmpty) return;
    final hasDefault = remaining.any((row) => row.isDefault);
    final chosen = hasDefault
        ? remaining.firstWhere((row) => row.isDefault)
        : remaining.first;
    if (!hasDefault) {
      await (db.update(db.detergentProfiles)
            ..where((t) => t.id.equals(chosen.id)))
          .write(const DetergentProfilesCompanion(isDefault: Value(true)));
    }
    final settings = await (db.select(
      db.appSettings,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (settings == null || settings.selectedDetergentId == null) {
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        AppSettingsCompanion(selectedDetergentId: Value(chosen.id)),
      );
    }
  });

  Future<void> setDefault(String id) async => db.transaction(() async {
    await db
        .update(db.detergentProfiles)
        .write(const DetergentProfilesCompanion(isDefault: Value(false)));
    await (db.update(db.detergentProfiles)..where((t) => t.id.equals(id)))
        .write(const DetergentProfilesCompanion(isDefault: Value(true)));
  });

  DetergentProfileModel _profile(DetergentProfile r) => DetergentProfileModel(
    id: r.id,
    name: r.name,
    brand: r.brand,
    detergentType: enumFromDb(DetergentType.values, r.detergentType),
    ruleStrategy: enumFromDb(RuleStrategy.values, r.ruleStrategy),
    doseBasis: enumFromDb(DoseBasis.values, r.doseBasis),
    canonicalUnit: enumFromDb(CanonicalUnit.values, r.canonicalUnit),
    preferredDisplayUnit: enumFromDb(
      DisplayUnit.values,
      r.preferredDisplayUnit,
    ),
    soilEnabled: r.soilEnabled,
    waterEnabled: r.waterEnabled,
    machineVariant: enumFromDb(MachineVariant.values, r.machineVariant),
    unknownWaterFallback: r.unknownWaterFallback,
    packageQuantityCanonical: r.packageQuantityCanonical,
    packagePrice: r.packagePrice,
    currencyCode: r.currencyCode,
    photoRelativePath: r.photoRelativePath,
    isDefault: r.isDefault,
    createdAtUtc: r.createdAtUtc.toUtc(),
    updatedAtUtc: r.updatedAtUtc.toUtc(),
  );
}
