import 'dart:async';

import 'package:uuid/uuid.dart';

import '../core/calculation/dose_calculator.dart';
import '../core/domain/models.dart';
import '../core/formatters/number_formatters.dart';
import '../data/repositories/history_repository.dart';
import '../data/repositories/settings_repository.dart';
import 'ad_policy.dart';
import 'ad_service.dart';

class LogWashOutcome {
  const LogWashOutcome({
    required this.logId,
    required this.adEligible,
    required this.localDateKey,
  });

  final String logId;
  final bool adEligible;
  final String localDateKey;
}

class LogWashService {
  LogWashService({
    required this.history,
    required this.adState,
    required this.ads,
  });

  final HistoryRepository history;
  final AdStateRepository adState;
  final InterstitialAdGateway ads;

  /// Persists the wash and consumes this wash's advertising eligibility.
  ///
  /// This method deliberately never shows an ad. The UI must first acknowledge
  /// that the wash was saved, then call [showEligibleAdAfterFeedback] at the
  /// natural break after that feedback has become visible.
  Future<LogWashOutcome> log({
    required DetergentBundle bundle,
    required DoseSelection selection,
    required DoseCalculation calculation,
    required String displayAmount,
    required String displayUnit,
    DateTime? now,
  }) async {
    if (!calculation.isOk) {
      throw StateError('Cannot log a missing/invalid dose.');
    }

    final clock = now ?? DateTime.now();
    final id = const Uuid().v4();
    final cost = DoseCalculator.costPerWash(
      bundle.profile,
      calculation.amountCanonical!,
    );
    final minor = cost == null || bundle.profile.currencyCode == null
        ? null
        : DoseFormatter.costMinorUnits(cost, bundle.profile.currencyCode!);

    await history.insert(
      WashLogModel(
        id: id,
        detergentId: bundle.profile.id,
        detergentNameSnapshot: bundle.profile.name,
        detergentTypeSnapshot: bundle.profile.detergentType,
        amountCanonical: calculation.amountCanonical!,
        canonicalUnit: bundle.profile.canonicalUnit,
        displayAmountSnapshot: displayAmount,
        displayUnitSnapshot: displayUnit,
        loadLevel: bundle.profile.doseBasis.name == 'loadSize'
            ? selection.load
            : null,
        soilLevel: bundle.profile.soilEnabled ? selection.soil : null,
        waterLevel: bundle.profile.waterEnabled
            ? calculation.resolvedWater ?? selection.water
            : null,
        costMinorUnits: minor,
        currencyCode: bundle.profile.currencyCode,
        loggedAtUtc: clock.toUtc(),
      ),
    );

    final before = await adState.get();
    final eligibility = AdPolicy.afterSuccessfulLog(
      before,
      nowLocal: clock,
      logId: id,
    );
    final date = AdPolicy.localDateKey(clock);
    final shownToday = before.adsShownDateLocal == date
        ? before.adsShownToday
        : 0;

    final next = AdStateModel(
      lifetimeSuccessfulLogs: before.lifetimeSuccessfulLogs + 1,
      lastInterstitialAtUtc: before.lastInterstitialAtUtc,
      adsShownToday: shownToday,
      adsShownDateLocal: date,
      firstSessionCompleted: before.firstSessionCompleted,
      // Eligibility is consumed by this natural break whether an ad is ready or
      // not. This prevents an ad from appearing later at an unrelated moment.
      lastEligibilityConsumedLogId: eligibility.eligible
          ? id
          : before.lastEligibilityConsumedLogId,
    );
    await adState.write(next);

    if (ads.isOperational && !ads.isReady) {
      // Never block the user's completed task while preparing an ad.
      unawaited(ads.preload());
    }

    return LogWashOutcome(
      logId: id,
      adEligible: eligibility.eligible,
      localDateKey: date,
    );
  }

  /// Shows an eligible interstitial only after the caller has presented the
  /// successful-save feedback. If no ad is ready, the eligibility is not moved
  /// to some later unrelated screen; the service simply prepares a future ad.
  Future<bool> showEligibleAdAfterFeedback(
    LogWashOutcome outcome, {
    DateTime? now,
  }) async {
    if (!outcome.adEligible) return false;

    if (!ads.isOperational) return false;
    if (!ads.isReady) {
      unawaited(ads.preload());
      return false;
    }

    final shown = await ads.showIfReady();
    if (!shown) return false;

    final clock = now ?? DateTime.now();
    final state = await adState.get();
    final date = AdPolicy.localDateKey(clock);
    final shownToday = state.adsShownDateLocal == date
        ? state.adsShownToday
        : 0;

    await adState.write(
      AdStateModel(
        lifetimeSuccessfulLogs: state.lifetimeSuccessfulLogs,
        lastInterstitialAtUtc: clock.toUtc(),
        adsShownToday: shownToday + 1,
        adsShownDateLocal: date,
        firstSessionCompleted: state.firstSessionCompleted,
        lastEligibilityConsumedLogId: outcome.logId,
      ),
    );
    return true;
  }
}
