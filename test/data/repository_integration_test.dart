import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/models.dart';
import 'package:laundry_dose/data/db/app_database.dart';
import 'package:laundry_dose/data/repositories/detergent_repository.dart';
import 'package:laundry_dose/data/repositories/settings_repository.dart';
import 'package:laundry_dose/data/repositories/history_repository.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import '../helpers/fixtures.dart';

DetergentBundle copyBundle(DetergentBundle source, String id, String name) {
  final p = source.profile;
  return DetergentBundle(
    profile: DetergentProfileModel(
      id: id,
      name: name,
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
      photoRelativePath: p.photoRelativePath,
      isDefault: false,
      createdAtUtc: p.createdAtUtc.add(const Duration(seconds: 1)),
      updatedAtUtc: p.updatedAtUtc.add(const Duration(seconds: 1)),
    ),
    rules: [
      for (final r in source.rules)
        DoseRuleModel(
          id: '${r.id}-$id',
          detergentId: id,
          loadLevel: r.loadLevel,
          soilLevel: r.soilLevel,
          waterLevel: r.waterLevel,
          amountCanonical: r.amountCanonical,
        ),
    ],
    adjustments: const [],
    markers: const [],
  );
}

void main() {
  late AppDatabase db;
  late DetergentRepository repo;
  late SettingsRepository settings;
  late HistoryRepository history;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DetergentRepository(db);
    settings = SettingsRepository(db);
    history = HistoryRepository(db);
  });
  tearDown(() async => db.close());
  test('bundle round trips and selected id persists', () async {
    final b = liquidBundle();
    await repo.saveBundle(b);
    await repo.ensureDefaultAndSelect(b.profile.id);
    final loaded = await repo.getBundle(b.profile.id);
    expect(loaded?.profile.name, 'Test');
    expect((await settings.get()).selectedDetergentId, b.profile.id);
  });
  test('deleting default promotes and selects remaining profile', () async {
    final first = liquidBundle();
    final second = copyBundle(first, 'd2', 'Second');
    await repo.saveBundle(first);
    await repo.ensureDefaultAndSelect(first.profile.id);
    await repo.saveBundle(second);
    await repo.deleteProfile(first.profile.id);
    final profiles = await repo.getProfiles();
    expect(profiles, hasLength(1));
    expect(profiles.single.id, 'd2');
    expect(profiles.single.isDefault, isTrue);
    expect((await settings.get()).selectedDetergentId, 'd2');
  });

  test(
    'deleting detergent preserves wash snapshot and nulls live relation',
    () async {
      final b = liquidBundle();
      await repo.saveBundle(b);
      await history.insert(
        WashLogModel(
          id: 'w1',
          detergentId: b.profile.id,
          detergentNameSnapshot: b.profile.name,
          detergentTypeSnapshot: b.profile.detergentType,
          amountCanonical: 35,
          canonicalUnit: CanonicalUnit.ml,
          displayAmountSnapshot: '35',
          displayUnitSnapshot: 'mL',
          loadLevel: LoadLevel.medium,
          loggedAtUtc: DateTime.utc(2026, 10, 7),
        ),
      );
      await repo.deleteProfile(b.profile.id);
      final logs = await history.watchLogs().first;
      expect(logs, hasLength(1));
      expect(logs.single.detergentId, isNull);
      expect(logs.single.detergentNameSnapshot, 'Test');
      expect(logs.single.amountCanonical, 35);
    },
  );
}
