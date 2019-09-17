import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/core/ads/ads.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/core/network/network_provider.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';
import 'package:http/http.dart' as http;

/*
TODO:

- Create a separated widget for the login screen that also handles the redirect
- Remove Authentication logic from UserDecksScreen
- Fix admob/firebase plits
- Add test for cardsStore getCardsFromSlots
- Remove zebra from loading more
- Create CardListItem view model
- Image Screen animation
- Transitions
- Error can't open url
- Add test for NoConnectionError
- Add test for TimeoutError
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

  NetworkProvider _networkProvider() {
    http.Client client = http.Client();
    return DefaultNetworkProvider(
      client: client,
      baseUrl: ThronesConstants.baseURL,
    );
  }

  ThronesService _thronesService() {
    return DefaultThronesService(network: _networkProvider());
  }

  _configAdMob(BuildContext context) {
    final appId = Theme.of(context).platform == TargetPlatform.iOS
        ? Ads.appIdIOS
        : Ads.appIdAndroid;
    FirebaseAdMob.instance.initialize(appId: appId);
  }

  MainScreen _mainScreen() {
    return MainScreen(
      thronesService: _thronesService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _configAdMob(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _mainScreen(),
      theme: Themes.app(),
      navigatorObservers: [
        observer,
      ],
    );
  }
}
