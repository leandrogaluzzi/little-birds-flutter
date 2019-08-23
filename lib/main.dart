import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/analytics/analytics_event.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';

/*
TODO:

- Filter safe area
- Filter Analytics
- Home Error Request
- Packs Error Request
- Card List Empty Search/Filter error
- CardScreen - Placeholder Image
- Image Screen animation
- CardsStore - improve cards with query
- Transitions
- Tab Icons Color
- Config CodeMagic.io
- Unit Tests (future)
- Widget Tests (future)
- Firebase - Ads (future)
- Local DB for cards (future)
*/

void main() => runApp(LittleBirdsApp());

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
