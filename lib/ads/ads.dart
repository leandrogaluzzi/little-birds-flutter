import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ads {
  static String appIdIOS = 'ca-app-pub-8070624639061262~8541487815';
  static String appIdAndroid = 'ca-app-pub-8070624639061262~7380414961';

  static String adUnitIdIOS = 'ca-app-pub-8070624639061262/1961934308';
  static String adUnitIdAndroid = 'ca-app-pub-8070624639061262/1807334710';

  static MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'game of thrones',
      'board games',
      'card games',
      'geek',
      'nerd',
      'lcg',
      'tcg',
    ],
    contentUrl: 'https://thronesdb.com',
    childDirected: false,
    testDevices: <String>[],
  );

  static InterstitialAd _interestitial(BuildContext context) {
    final unitId = Theme.of(context).platform == TargetPlatform.iOS
        ? Ads.adUnitIdIOS
        : Ads.adUnitIdAndroid;

    return InterstitialAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: unitId,
        targetingInfo: _targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        });
  }

  static showInterestial(BuildContext context) {
    final interstitial = _interestitial(context);
    interstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }
}
