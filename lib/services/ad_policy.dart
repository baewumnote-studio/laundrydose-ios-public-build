import '../core/domain/models.dart';

class AdEligibility {
  const AdEligibility(this.eligible, this.reason);

  final bool eligible;
  final String reason;
}

class AdPolicy {
  static const graceSuccessfulLogs = 6;
  static const logsPerEligibility = 4;
  static const minimumInterval = Duration(minutes: 20);
  static const dailyMaximum = 2;

  static AdEligibility afterSuccessfulLog(
    AdStateModel before, {
    required DateTime nowLocal,
    required String logId,
  }) {
    if (!before.firstSessionCompleted) {
      return const AdEligibility(false, 'first_session');
    }

    final afterCount = before.lifetimeSuccessfulLogs + 1;
    if (afterCount <= graceSuccessfulLogs) {
      return const AdEligibility(false, 'grace');
    }
    if ((afterCount - graceSuccessfulLogs) % logsPerEligibility != 0) {
      return const AdEligibility(false, 'not_fourth_post_grace');
    }

    final date = localDateKey(nowLocal);
    final shownToday = before.adsShownDateLocal == date
        ? before.adsShownToday
        : 0;
    if (shownToday >= dailyMaximum) {
      return const AdEligibility(false, 'daily_maximum');
    }

    final lastShown = before.lastInterstitialAtUtc;
    if (lastShown != null &&
        nowLocal.toUtc().difference(lastShown) < minimumInterval) {
      return const AdEligibility(false, 'cooldown');
    }

    if (before.lastEligibilityConsumedLogId == logId) {
      return const AdEligibility(false, 'already_consumed');
    }
    return const AdEligibility(true, 'eligible');
  }

  static String localDateKey(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';
}
