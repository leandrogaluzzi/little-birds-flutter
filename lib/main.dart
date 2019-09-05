import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/analytics/analytics_event.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';

/*
TODO:

- Image Screen animation
- Transitions
- Show pack in card cell
- Error can't open url
- Unit Tests
- Widget Tests
- Firebase - Ads
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
