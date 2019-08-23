import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/analytics/analytics_event.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/thrones_pack.dart';

class Analytics {
  static track(
      {@required AnalyticsEvent event, Map<String, dynamic> parameters}) {
    FirebaseAnalytics().logEvent(
      name: event.toString(),
      parameters: parameters,
    );
  }

  static trackDeck(ThronesDeck deck) {
    Map<String, dynamic> parameters = {'id': deck.id, 'name': deck.name};
    track(event: AnalyticsEvent.deck, parameters: parameters);
  }

  static trackCard(ThronesCard card) {
    Map<String, dynamic> parameters = {'code': card.code, 'name': card.name};
    track(event: AnalyticsEvent.card, parameters: parameters);
  }

  static trackPack(ThronesPack pack) {
    Map<String, dynamic> parameters = {'code': pack.code, 'name': pack.name};
    track(event: AnalyticsEvent.card, parameters: parameters);
  }

  /*static trackSearch(String query) {
    Map<String, dynamic> parameters = {'text': query};
    track(event: AnalyticsEvent.search, parameters: parameters);
  }

  static trackFilter(Filter filter) {
    track(event: AnalyticsEvent.filter);
  }*/
}
