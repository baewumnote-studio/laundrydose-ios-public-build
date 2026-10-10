import 'package:flutter/foundation.dart';

class AdConfiguration {
  const AdConfiguration._();
  static const testIosInterstitial = 'ca-app-pub-3940256099942544/4411468910';
  static const useTestAds = bool.fromEnvironment('LAUNDRY_DOSE_TEST_ADS');
  static const _productionIosInterstitial = String.fromEnvironment(
    'ADMOB_IOS_INTERSTITIAL_ID',
  );
  static String get iosInterstitial => selectIosInterstitial(
    debugBuild: kDebugMode,
    testAds: useTestAds,
    productionId: _productionIosInterstitial,
  );

  // A release-built TestFlight app must explicitly opt into sample ads.
  static String selectIosInterstitial({
    required bool debugBuild,
    required bool testAds,
    required String productionId,
  }) => debugBuild || testAds ? testIosInterstitial : productionId.trim();
}
