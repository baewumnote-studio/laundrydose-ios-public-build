import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/config/ad_configuration.dart';

void main() {
  test('release beta uses sample ads even when a production ID is present', () {
    expect(
      AdConfiguration.selectIosInterstitial(
        debugBuild: false,
        testAds: true,
        productionId: 'production-id',
      ),
      AdConfiguration.testIosInterstitial,
    );
  });
  test('production release never silently falls back to test ads', () {
    expect(
      AdConfiguration.selectIosInterstitial(
        debugBuild: false,
        testAds: false,
        productionId: '',
      ),
      isEmpty,
    );
    expect(
      AdConfiguration.selectIosInterstitial(
        debugBuild: false,
        testAds: false,
        productionId: ' production-id ',
      ),
      'production-id',
    );
  });
  test('debug cannot send requests to a production ad unit', () {
    expect(
      AdConfiguration.selectIosInterstitial(
        debugBuild: true,
        testAds: false,
        productionId: 'production-id',
      ),
      AdConfiguration.testIosInterstitial,
    );
  });
}
