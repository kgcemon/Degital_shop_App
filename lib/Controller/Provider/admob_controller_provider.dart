import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAdsController extends ChangeNotifier {
  BannerAd? bannerAd;
  bool isLoaded = false;
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

  InterstitialAd? interstitialAd;

  final interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/6308507378'
      : 'ca-app-pub-3940256099942544/4411468910';

  final String nativeAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/4312899425'
      : 'ca-app-pub-3940256099942544/3986624511';

  final bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-9662671355476806/8614072678'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadAdBannerAds() {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }




  void showInterstitialAd() {
    if(interstitialAd == null){
      InterstitialAd.load(
          adUnitId: interstitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              debugPrint('$ad loaded.');
              // Keep a reference to the ad so you can show it later.
              interstitialAd = ad;
              notifyListeners();
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('InterstitialAd failed to load: $error');
            },
          ));
    }else{
      interstitialAd?.dispose();
    }
  }

}
