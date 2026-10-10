import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentResult {
  const ConsentResult({
    required this.canRequestAds,
    required this.privacyOptionsRequired,
    this.updateError,
    this.formError,
  });

  final bool canRequestAds;
  final bool privacyOptionsRequired;
  final FormError? updateError;
  final FormError? formError;
}

class ConsentService {
  /// Refreshes UMP consent state. A form is shown only after a successful
  /// consent-info update, matching Google's recommended startup sequence.
  /// Existing consent state is still queried if the refresh itself fails so a
  /// transient network error never blocks the rest of the app.
  Future<ConsentResult> gather() async {
    final update = Completer<FormError?>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () => update.complete(null),
      (error) => update.complete(error),
    );
    final updateError = await update.future;

    FormError? formError;
    if (updateError == null) {
      final form = Completer<FormError?>();
      ConsentForm.loadAndShowConsentFormIfRequired(
        (error) => form.complete(error),
      );
      formError = await form.future;
    }

    final can = await ConsentInformation.instance.canRequestAds();
    final required =
        await ConsentInformation.instance
            .getPrivacyOptionsRequirementStatus() ==
        PrivacyOptionsRequirementStatus.required;
    return ConsentResult(
      canRequestAds: can,
      privacyOptionsRequired: required,
      updateError: updateError,
      formError: formError,
    );
  }

  Future<bool> isPrivacyOptionsRequired() async =>
      await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() ==
      PrivacyOptionsRequirementStatus.required;

  Future<void> showPrivacyOptions() async {
    final result = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((_) => result.complete());
    await result.future;
  }
}
