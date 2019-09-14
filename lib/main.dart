import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/ads/ads.dart';
import 'package:little_birds/analytics/analytics_event.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';

/*
TODO:

- Create CardListItem view model
- Image Screen animation
- Transitions
- Error can't open url
- Test NoConnectionError
- Test TimeoutError
- Widget Tests
- Local DB for cards
- Send crash logs to email
*/

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(LittleBirdsApp());
}

class LittleBirdsApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    analytics.logEvent(name: AnalyticsEvent.filter.toString());

    final appId = Theme.of(context).platform == TargetPlatform.iOS
        ? Ads.appIdIOS
        : Ads.appIdAndroid;
    FirebaseAdMob.instance.initialize(appId: appId);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: Themes.app(),
      navigatorObservers: [
        observer,
      ],
    );
  }
}
