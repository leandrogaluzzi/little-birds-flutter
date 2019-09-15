import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/core/ads/ads.dart';
import 'package:little_birds/core/analytics/analytics_event.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/core/network/network_provider.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';
import 'package:http/http.dart' as http;

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

  NetworkProvider _networkProvider() {
    http.Client client = http.Client();
    return DefaultNetworkProvider(
      client: client,
      baseUrl: ThronesConstants.baseURL,
    );
  }

  ThronesService _thrones() {
    return DefaultThronesService(network: _networkProvider());
  }

  SecureStorage _storage() {
    return SecureStorage();
  }

  _configAdMob(BuildContext context) {
    final appId = Theme.of(context).platform == TargetPlatform.iOS
        ? Ads.appIdIOS
        : Ads.appIdAndroid;
    FirebaseAdMob.instance.initialize(appId: appId);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _configAdMob(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(
        thrones: _thrones(),
        storage: _storage(),
      ),
      theme: Themes.app(),
      navigatorObservers: [
        observer,
      ],
    );
  }
}
