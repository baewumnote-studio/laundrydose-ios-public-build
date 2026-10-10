import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/db/app_database.dart';
import '../data/repositories/detergent_repository.dart';
import '../data/repositories/history_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../core/domain/models.dart';
import '../services/ad_service.dart';
import '../services/consent_service.dart';
import '../services/photo_service.dart';
import '../services/log_wash_service.dart';
import '../services/label_scan_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
final detergentRepositoryProvider = Provider(
  (ref) => DetergentRepository(ref.watch(databaseProvider)),
);
final historyRepositoryProvider = Provider(
  (ref) => HistoryRepository(ref.watch(databaseProvider)),
);
final settingsRepositoryProvider = Provider(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);
final adStateRepositoryProvider = Provider(
  (ref) => AdStateRepository(ref.watch(databaseProvider)),
);
final photoServiceProvider = Provider((ref) => PhotoService());
final labelScanServiceProvider = Provider((ref) => LabelScanService());
final consentServiceProvider = Provider((ref) => ConsentService());
final adServiceProvider = Provider((ref) {
  final s = AdService();
  ref.onDispose(s.dispose);
  return s;
});
final logWashServiceProvider = Provider(
  (ref) => LogWashService(
    history: ref.watch(historyRepositoryProvider),
    adState: ref.watch(adStateRepositoryProvider),
    ads: ref.watch(adServiceProvider),
  ),
);
final profilesProvider = StreamProvider(
  (ref) => ref.watch(detergentRepositoryProvider).watchProfiles(),
);
final settingsProvider = StreamProvider<AppSettingsModel>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);
final historyProvider = StreamProvider(
  (ref) => ref.watch(historyRepositoryProvider).watchLogs(),
);
final selectedBundleProvider = StreamProvider<DetergentBundle?>((ref) {
  final settings = ref.watch(settingsProvider).value;
  final profiles = ref.watch(profilesProvider).value ?? const [];
  String? id = settings?.selectedDetergentId;
  id ??= profiles.where((p) => p.isDefault).firstOrNull?.id;
  id ??= profiles.firstOrNull?.id;
  if (id == null) return Stream.value(null);
  return ref.watch(detergentRepositoryProvider).watchBundle(id);
});

extension FirstOrNullX<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
