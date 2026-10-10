import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    DetergentProfiles,
    DoseRules,
    DoseAdjustments,
    MeasureMarkers,
    WashLogs,
    AppSettings,
    AdStates,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'laundry_dose',
              native: DriftNativeOptions(
                databaseDirectory: getApplicationSupportDirectory,
              ),
            ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await into(appSettings).insert(
        const AppSettingsCompanion(id: Value(1)),
        mode: InsertMode.insertOrIgnore,
      );
      await into(adStates).insert(
        const AdStatesCompanion(id: Value(1)),
        mode: InsertMode.insertOrIgnore,
      );
    },
  );
}
