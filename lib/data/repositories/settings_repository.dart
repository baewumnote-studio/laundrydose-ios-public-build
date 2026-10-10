import 'package:drift/drift.dart';
import '../../core/domain/enums.dart';
import '../../core/domain/models.dart';
import '../db/app_database.dart';

class SettingsRepository {
  SettingsRepository(this.db);
  final AppDatabase db;
  Stream<AppSettingsModel> watch() => (db.select(
    db.appSettings,
  )..where((t) => t.id.equals(1))).watchSingle().map(_map);
  Future<AppSettingsModel> get() async => _map(
    await (db.select(db.appSettings)..where((t) => t.id.equals(1))).getSingle(),
  );
  Future<void> update({
    bool? onboardingCompleted,
    ThemeChoice? themeMode,
    String? localeOverride,
    bool clearLocale = false,
    UnitSystemChoice? unitSystem,
    LoadLevel? defaultLoadLevel,
    SoilLevel? defaultSoilLevel,
    WaterLevel? defaultWaterLevel,
    String? selectedDetergentId,
    bool clearSelected = false,
    ReducedMotionChoice? reducedMotionOverride,
  }) async {
    await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
      AppSettingsCompanion(
        onboardingCompleted: onboardingCompleted == null
            ? const Value.absent()
            : Value(onboardingCompleted),
        themeMode: themeMode == null
            ? const Value.absent()
            : Value(themeMode.dbName),
        localeOverride: clearLocale
            ? const Value(null)
            : localeOverride == null
            ? const Value.absent()
            : Value(localeOverride),
        unitSystem: unitSystem == null
            ? const Value.absent()
            : Value(unitSystem.dbName),
        defaultLoadLevel: defaultLoadLevel == null
            ? const Value.absent()
            : Value(defaultLoadLevel.dbName),
        defaultSoilLevel: defaultSoilLevel == null
            ? const Value.absent()
            : Value(defaultSoilLevel.dbName),
        defaultWaterLevel: defaultWaterLevel == null
            ? const Value.absent()
            : Value(defaultWaterLevel.dbName),
        selectedDetergentId: clearSelected
            ? const Value(null)
            : selectedDetergentId == null
            ? const Value.absent()
            : Value(selectedDetergentId),
        reducedMotionOverride: reducedMotionOverride == null
            ? const Value.absent()
            : Value(reducedMotionOverride.dbName),
      ),
    );
  }

  AppSettingsModel _map(AppSetting r) => AppSettingsModel(
    onboardingCompleted: r.onboardingCompleted,
    themeMode: enumFromDb(ThemeChoice.values, r.themeMode),
    localeOverride: r.localeOverride,
    unitSystem: enumFromDb(UnitSystemChoice.values, r.unitSystem),
    defaultLoadLevel: enumFromDb(LoadLevel.values, r.defaultLoadLevel),
    defaultSoilLevel: enumFromDb(SoilLevel.values, r.defaultSoilLevel),
    defaultWaterLevel: enumFromDb(WaterLevel.values, r.defaultWaterLevel),
    selectedDetergentId: r.selectedDetergentId,
    reducedMotionOverride: enumFromDb(
      ReducedMotionChoice.values,
      r.reducedMotionOverride,
    ),
  );
}

class AdStateRepository {
  AdStateRepository(this.db);
  final AppDatabase db;
  Future<AdStateModel> get() async => _map(
    await (db.select(db.adStates)..where((t) => t.id.equals(1))).getSingle(),
  );
  Future<void> write(AdStateModel s) =>
      (db.update(db.adStates)..where((t) => t.id.equals(1))).write(
        AdStatesCompanion(
          lifetimeSuccessfulLogs: Value(s.lifetimeSuccessfulLogs),
          lastInterstitialAtUtc: Value(s.lastInterstitialAtUtc),
          adsShownToday: Value(s.adsShownToday),
          adsShownDateLocal: Value(s.adsShownDateLocal),
          firstSessionCompleted: Value(s.firstSessionCompleted),
          lastEligibilityConsumedLogId: Value(s.lastEligibilityConsumedLogId),
        ),
      );
  AdStateModel _map(AdState r) => AdStateModel(
    lifetimeSuccessfulLogs: r.lifetimeSuccessfulLogs,
    lastInterstitialAtUtc: r.lastInterstitialAtUtc?.toUtc(),
    adsShownToday: r.adsShownToday,
    adsShownDateLocal: r.adsShownDateLocal,
    firstSessionCompleted: r.firstSessionCompleted,
    lastEligibilityConsumedLogId: r.lastEligibilityConsumedLogId,
  );
}
