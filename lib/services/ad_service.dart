import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/config/ad_configuration.dart';

abstract interface class InterstitialAdGateway {
  bool get isReady;
  bool get isOperational;
  Future<void> preload();
  Future<bool> showIfReady();
}

class AdService implements InterstitialAdGateway {
  InterstitialAd? _ad;
  bool _loading = false;
  bool _initialized = false;

  String get _unitId => AdConfiguration.iosInterstitial;
  @override
  bool get isOperational => _initialized && _unitId.isNotEmpty;

  Future<void> initialize() async {
    if (_initialized || _unitId.isEmpty) return;
    await MobileAds.instance.initialize();
    _initialized = true;
  }

  @override
  Future<void> preload() async {
    if (!isOperational || _loading || _ad != null) return;
    _loading = true;
    final done = Completer<void>();
    InterstitialAd.load(
      adUnitId: _unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _loading = false;
          _ad = ad;
          done.complete();
        },
        onAdFailedToLoad: (_) {
          _loading = false;
          _ad = null;
          done.complete();
        },
      ),
    );
    await done.future;
  }

  @override
  bool get isReady => isOperational && _ad != null;

  @override
  Future<bool> showIfReady() async {
    if (!isOperational) return false;
    final ad = _ad;
    if (ad == null) return false;
    _ad = null;
    final done = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!done.isCompleted) done.complete(true);
        unawaited(preload());
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        if (!done.isCompleted) done.complete(false);
        unawaited(preload());
      },
    );
    ad.show();
    return done.future;
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
