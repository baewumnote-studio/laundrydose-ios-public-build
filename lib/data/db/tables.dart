import 'package:drift/drift.dart';

class DetergentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get brand => text().nullable()();
  TextColumn get detergentType => text()();
  TextColumn get ruleStrategy =>
      text().withDefault(const Constant('base_plus_adjustments'))();
  TextColumn get doseBasis => text().withDefault(const Constant('load_size'))();
  TextColumn get canonicalUnit => text()();
  TextColumn get preferredDisplayUnit => text()();
  BoolColumn get soilEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get waterEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get machineVariant => text().withDefault(const Constant('any'))();
  TextColumn get unknownWaterFallback => text().nullable()();
  RealColumn get packageQuantityCanonical => real().nullable()();
  RealColumn get packagePrice => real().nullable()();
  TextColumn get currencyCode => text().nullable()();
  TextColumn get photoRelativePath => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DoseRules extends Table {
  TextColumn get id => text()();
  TextColumn get detergentId =>
      text().references(DetergentProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get loadLevel => text().nullable()();
  TextColumn get soilLevel => text().nullable()();
  TextColumn get waterLevel => text().nullable()();
  RealColumn get amountCanonical => real()();
  DateTimeColumn get createdAtUtc => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DoseAdjustments extends Table {
  TextColumn get id => text()();
  TextColumn get detergentId =>
      text().references(DetergentProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get dimension => text()();
  TextColumn get optionKey => text()();
  RealColumn get deltaCanonical => real().withDefault(const Constant(0))();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MeasureMarkers extends Table {
  TextColumn get id => text()();
  TextColumn get detergentId =>
      text().references(DetergentProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text().withLength(min: 1, max: 24)();
  RealColumn get amountCanonical => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WashLogs extends Table {
  TextColumn get id => text()();
  TextColumn get detergentId => text().nullable().references(
    DetergentProfiles,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get detergentNameSnapshot => text()();
  TextColumn get detergentTypeSnapshot => text()();
  RealColumn get amountCanonical => real()();
  TextColumn get canonicalUnit => text()();
  TextColumn get displayAmountSnapshot => text()();
  TextColumn get displayUnitSnapshot => text()();
  TextColumn get loadLevel => text().nullable()();
  TextColumn get soilLevel => text().nullable()();
  TextColumn get waterLevel => text().nullable()();
  IntColumn get costMinorUnits => integer().nullable()();
  TextColumn get currencyCode => text().nullable()();
  DateTimeColumn get loggedAtUtc => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get localeOverride => text().nullable()();
  TextColumn get unitSystem => text().withDefault(const Constant('auto'))();
  TextColumn get defaultLoadLevel =>
      text().withDefault(const Constant('medium'))();
  TextColumn get defaultSoilLevel =>
      text().withDefault(const Constant('normal'))();
  TextColumn get defaultWaterLevel =>
      text().withDefault(const Constant('unknown'))();
  TextColumn get selectedDetergentId => text().nullable().references(
    DetergentProfiles,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get reducedMotionOverride =>
      text().withDefault(const Constant('system'))();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AdStates extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get lifetimeSuccessfulLogs =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get lastInterstitialAtUtc => dateTime().nullable()();
  IntColumn get adsShownToday => integer().withDefault(const Constant(0))();
  TextColumn get adsShownDateLocal => text().nullable()();
  BoolColumn get firstSessionCompleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastEligibilityConsumedLogId => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}
