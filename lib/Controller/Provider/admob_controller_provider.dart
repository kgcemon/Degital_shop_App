import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAdsController extends ChangeNotifier {
  // Banner Ad
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  // Native Ad
  NativeAd? _nativeAd;
  bool _isNativeAdLoaded = false;

  // Interstitial Ad
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  // Getters
  BannerAd? get bannerAd => _bannerAd;
  bool get isBannerAdLoaded => _isBannerAdLoaded;
  NativeAd? get nativeAd => _nativeAd;
  bool get isNativeAdLoaded => _isNativeAdLoaded;
  bool get isInterstitialAdLoaded => _isInterstitialAdLoaded;

  // Ad Unit IDs
  final String _interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/6308507378'
      : 'ca-app-pub-3940256099942544/4411468910';

  final String _nativeAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/4312899425'
      : 'ca-app-pub-3940256099942544/3986624511';

  final String _bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/8614072678'
      : 'ca-app-pub-3940256099942544/2934735716';

  // Banner Ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('BannerAd loaded successfully.');
          _isBannerAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          _isBannerAdLoaded = false;
          ad.dispose();
        },
        onAdOpened: (ad) => debugPrint('BannerAd opened.'),
        onAdClosed: (ad) => debugPrint('BannerAd closed.'),
      ),
    );
    _bannerAd!.load();
  }

  // Native Ad
  void loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: _nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('NativeAd loaded successfully.');
          _isNativeAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('NativeAd failed to load: $error');
          _isNativeAdLoaded = false;
          ad.dispose();
        },
        onAdOpened: (ad) => debugPrint('NativeAd opened.'),
        onAdClosed: (ad) => debugPrint('NativeAd closed.'),
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: Colors.blue,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey[600],
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.italic,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey[800],
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
    );
    _nativeAd!.load();
  }

  // Interstitial Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
          debugPrint('InterstitialAd loaded successfully.');
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('InterstitialAd showed fullscreen content.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('InterstitialAd dismissed fullscreen content.');
        ad.dispose();
        loadInterstitialAd(); // Load a new ad
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('InterstitialAd failed to show fullscreen content: $error');
        ad.dispose();
        loadInterstitialAd(); // Try to load a new ad
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null; // Reset the ad after showing
    _isInterstitialAdLoaded = false;
    notifyListeners();
  }

  // Dispose method to clean up resources
  @override
  void dispose() {
    _bannerAd?.dispose();
    _nativeAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}