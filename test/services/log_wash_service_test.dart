import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/domain/models.dart';
import 'package:laundry_dose/data/db/app_database.dart';
import 'package:laundry_dose/data/repositories/detergent_repository.dart';
import 'package:laundry_dose/data/repositories/history_repository.dart';
import 'package:laundry_dose/data/repositories/settings_repository.dart';
import 'package:laundry_dose/services/ad_service.dart';
import 'package:laundry_dose/services/log_wash_service.dart';
import '../helpers/fixtures.dart';

class FakeAds implements InterstitialAdGateway {
  FakeAds({this.operational = true, this.ready = true});
  bool operational, ready;
  int shows = 0, preloads = 0;
  @override
  bool get isOperational => operational;
  @override
  bool get isReady => operational && ready;
  @override
  Future<void> preload() async {
    preloads++;
  }

  @override
  Future<bool> showIfReady() async {
    if (!isReady) return false;
    shows++;
    ready = false;
    return true;
  }
}

void main() {
  late AppDatabase db;
  late HistoryRepository history;
  late AdStateRepository state;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    history = HistoryRepository(db);
    state = AdStateRepository(db);
    await DetergentRepository(db).saveBundle(liquidBundle());
  });
  tearDown(() async => db.close());
  test('log persists before an eligible ad is displayed', () async {
    final ads = FakeAds();
    final service = LogWashService(history: history, adState: state, ads: ads);
    await state.write(
      const AdStateModel(
        lifetimeSuccessfulLogs: 9,
        adsShownToday: 0,
        firstSessionCompleted: true,
      ),
    );
    final now = DateTime(2026, 10, 7, 12);
    final out = await service.log(
      bundle: liquidBundle(),
      selection: const DoseSelection(load: LoadLevel.medium),
      calculation: const DoseCalculation.ok(35),
      displayAmount: '35',
      displayUnit: 'mL',
      now: now,
    );
    expect(out.adEligible, isTrue);
    expect(ads.shows, 0);
    expect((await history.watchLogs().first), hasLength(1));
    expect(await service.showEligibleAdAfterFeedback(out, now: now), isTrue);
    expect(ads.shows, 1);
  });

  test(
    'eligible log with no ready ad does not increment shown count',
    () async {
      final ads = FakeAds(ready: false);
      final service = LogWashService(
        history: history,
        adState: state,
        ads: ads,
      );
      await state.write(
        const AdStateModel(
          lifetimeSuccessfulLogs: 9,
          adsShownToday: 0,
          firstSessionCompleted: true,
        ),
      );
      final now = DateTime(2026, 10, 7, 12);
      final out = await service.log(
        bundle: liquidBundle(),
        selection: const DoseSelection(load: LoadLevel.medium),
        calculation: const DoseCalculation.ok(35),
        displayAmount: '35',
        displayUnit: 'mL',
        now: now,
      );
      expect(out.adEligible, isTrue);
      expect(await service.showEligibleAdAfterFeedback(out, now: now), isFalse);
      final after = await state.get();
      expect(after.adsShownToday, 0);
      expect(after.lastInterstitialAtUtc, isNull);
      expect(ads.shows, 0);
    },
  );
}
