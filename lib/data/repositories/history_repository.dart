import 'package:drift/drift.dart';
import '../../core/domain/enums.dart';
import '../../core/domain/models.dart';
import '../db/app_database.dart';

class HistoryRepository {
  HistoryRepository(this.db);
  final AppDatabase db;
  Stream<List<WashLogModel>> watchLogs({int limit = 200}) =>
      (db.select(db.washLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAtUtc)])
            ..limit(limit))
          .watch()
          .map((rows) => rows.map(_map).toList());
  Future<void> insert(WashLogModel x) => db
      .into(db.washLogs)
      .insert(
        WashLogsCompanion.insert(
          id: x.id,
          detergentId: Value(x.detergentId),
          detergentNameSnapshot: x.detergentNameSnapshot,
          detergentTypeSnapshot: x.detergentTypeSnapshot.dbName,
          amountCanonical: x.amountCanonical,
          canonicalUnit: x.canonicalUnit.dbName,
          displayAmountSnapshot: x.displayAmountSnapshot,
          displayUnitSnapshot: x.displayUnitSnapshot,
          loadLevel: Value(x.loadLevel?.dbName),
          soilLevel: Value(x.soilLevel?.dbName),
          waterLevel: Value(x.waterLevel?.dbName),
          costMinorUnits: Value(x.costMinorUnits),
          currencyCode: Value(x.currencyCode),
          loggedAtUtc: x.loggedAtUtc,
        ),
      );
  Future<void> deleteById(String id) =>
      (db.delete(db.washLogs)..where((t) => t.id.equals(id))).go();
  WashLogModel _map(WashLog r) => WashLogModel(
    id: r.id,
    detergentId: r.detergentId,
    detergentNameSnapshot: r.detergentNameSnapshot,
    detergentTypeSnapshot: enumFromDb(
      DetergentType.values,
      r.detergentTypeSnapshot,
    ),
    amountCanonical: r.amountCanonical,
    canonicalUnit: enumFromDb(CanonicalUnit.values, r.canonicalUnit),
    displayAmountSnapshot: r.displayAmountSnapshot,
    displayUnitSnapshot: r.displayUnitSnapshot,
    loadLevel: r.loadLevel == null
        ? null
        : enumFromDb(LoadLevel.values, r.loadLevel!),
    soilLevel: r.soilLevel == null
        ? null
        : enumFromDb(SoilLevel.values, r.soilLevel!),
    waterLevel: r.waterLevel == null
        ? null
        : enumFromDb(WaterLevel.values, r.waterLevel!),
    costMinorUnits: r.costMinorUnits,
    currencyCode: r.currencyCode,
    loggedAtUtc: r.loggedAtUtc.toUtc(),
  );
}
