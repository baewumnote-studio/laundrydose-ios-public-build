import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/models.dart';
import 'package:laundry_dose/services/ad_policy.dart';

AdStateModel state(
  int logs, {
  bool first = true,
  DateTime? last,
  int shown = 0,
  String? date,
  String? consumed,
}) => AdStateModel(
  lifetimeSuccessfulLogs: logs,
  lastInterstitialAtUtc: last,
  adsShownToday: shown,
  adsShownDateLocal: date,
  firstSessionCompleted: first,
  lastEligibilityConsumedLogId: consumed,
);

void main() {
  final now = DateTime(2026, 10, 7, 12);

  test('first session never eligible', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, first: false),
        nowLocal: now,
        logId: 'x',
      ).eligible,
      isFalse,
    );
  });

  test('first six lifetime successful logs are grace', () {
    for (var before = 0; before < 6; before++) {
      expect(
        AdPolicy.afterSuccessfulLog(
          state(before),
          nowLocal: now,
          logId: '$before',
        ).eligible,
        isFalse,
      );
    }
  });

  test('first eligibility is the 10th successful log', () {
    expect(
      AdPolicy.afterSuccessfulLog(state(8), nowLocal: now, logId: '9').eligible,
      isFalse,
    );
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9),
        nowLocal: now,
        logId: '10',
      ).eligible,
      isTrue,
    );
  });

  test('daily cap blocks', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, shown: 2, date: '2026-10-07'),
        nowLocal: now,
        logId: 'x',
      ).eligible,
      isFalse,
    );
  });

  test('cooldown uses supplied clock and blocks under 20 minutes', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, last: now.toUtc().subtract(const Duration(minutes: 5))),
        nowLocal: now,
        logId: 'x',
      ).eligible,
      isFalse,
    );
  });

  test('cooldown clears at 20 minutes', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, last: now.toUtc().subtract(const Duration(minutes: 20))),
        nowLocal: now,
        logId: 'x',
      ).eligible,
      isTrue,
    );
  });

  test('new local day resets previous day daily count', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, shown: 2, date: '2026-10-06'),
        nowLocal: now,
        logId: 'new-day',
      ).eligible,
      isTrue,
    );
  });

  test('eligibility repeats every four logs after grace', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(13),
        nowLocal: now,
        logId: '14',
      ).eligible,
      isTrue,
    );
    expect(
      AdPolicy.afterSuccessfulLog(
        state(14),
        nowLocal: now,
        logId: '15',
      ).eligible,
      isFalse,
    );
    expect(
      AdPolicy.afterSuccessfulLog(
        state(17),
        nowLocal: now,
        logId: '18',
      ).eligible,
      isTrue,
    );
  });

  test('same eligibility log cannot be consumed twice', () {
    expect(
      AdPolicy.afterSuccessfulLog(
        state(9, consumed: 'same'),
        nowLocal: now,
        logId: 'same',
      ).eligible,
      isFalse,
    );
  });
}
