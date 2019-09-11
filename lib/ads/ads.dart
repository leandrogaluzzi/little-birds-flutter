import 'package:firebase_admob/firebase_admob.dart';

class Ads {
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

  static InterstitialAd _interstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: _targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  static showInterestial() {
    _interstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }
}
